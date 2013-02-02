class User < ActiveRecord::Base 
	ROLES  = { member: 'MEMBER', pending: 'PENDING',  admin: 'ADMIN' }
	has_secure_password
	attr_accessible :username, :email, :password,:password_confirmation, :first_name, :last_name, :role, :auth_token, :confirmed
	validates_presence_of :username, :email
	validates_presence_of :password, :password_confirmation, :on => :create 
	validates_uniqueness_of :email, :username, case_sensitive: false

	validates_format_of :username, with: /^[A-Za-z0-9_-]{5,15}$/
	validates_format_of :email, with: /^[A-Z_a-z0-9-]+(\.[A-Z_a-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,4})$/

	validates :password, format: {with: /[\d\w\\\!#$@%^&*()\+-='\[\]:>?"{}]{5,32}/}, :on => :create
	
	validates_format_of :first_name, :last_name, with: /[A-Za-z]{0,32}/

	before_create :add_auth_token

	def add_auth_token 
		self.assign_attributes role: ROLES[:pending], auth_token: SecureRandom.hex(20) 
		ActivationMailer.activation_email(self).deliver
	end

	def to_param
		username if username.present?
	end

	def confirmed?
		self.confirmed
	end

	def self.authenticate(options = {})
		#need to maybe add ability to use username or email.
		user = User.find_by_username(options[:username])
		if user && user.try(:authenticate,options[:password])
			return user
		end
		return nil
	end
end