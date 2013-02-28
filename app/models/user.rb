class User < ActiveRecord::Base 
	# REPEATED CODE. SAME IN HELPER. FIX!
	ROLES  = { member: 'Member', pending: 'Pending',  moderator: 'Moderator', admin: 'Admin' }
	has_secure_password
	attr_accessible :username, :email, :password,:password_confirmation, :first_name, 
	:last_name, :role, :activation_token, :confirmed, :remember_token,
	:bio, :occupation, :location, :reset_token, :reset_token_expiration
	validates_presence_of :username, :email
	validates_presence_of :password, :password_confirmation, on: :create 
	validates_uniqueness_of :email, :username, case_sensitive: false

	validates_format_of :username, with: /^[A-Za-z0-9_-]{5,15}$/
	validates_format_of :email, with: /^[A-Z_a-z0-9-]+(\.[A-Z_a-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,4})$/
  validates :password,format: {with: /[\d\w\\\!#$@%^&*()\+-='\[\]:>?"{}]{5,32}/}, allow_blank: true,on: :update
	validates :password, format: {with: /[\d\w\\\!#$@%^&*()\+-='\[\]:>?"{}]{5,32}/}, on: :create
	
	validates_format_of :first_name, :last_name, with: /[A-Za-z]{0,32}/,allow_blank: true

	before_create :add_activation_token #auth used for ACTIVATION. 
	before_create :add_remember_token

	def confirmed?
		self.confirmed
	end

	def self.authenticate(username_or_email,password)
		user = User.find_by_username(username_or_email) || User.find_by_email(username_or_email)
		return user if user && user.try(:authenticate,password)
		return nil
	end
	def to_param
		username if username.present?
	end

	def add_reset_token
		generate_token(:reset_token)
		update_attributes reset_token_expiration: 3.hours.from_now
	end

	private
	def add_activation_token 
		self.assign_attributes role: ROLES[:pending], activation_token: SecureRandom.hex(20) 
		UserMailer.activation_email(self).deliver
	end

	def add_remember_token
		generate_token(:remember_token)
	end


	#Generates UNIQUE tokens for a given column 
	#from Rails casts
	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end
end