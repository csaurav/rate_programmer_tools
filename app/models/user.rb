#	* --- NOTE --- *
# Upon adding ANY fields, ensure if format validation is not applied
# then in the sanitize_fields function add the name of your field.
class User < ActiveRecord::Base
 	include ActionView::Helpers::SanitizeHelper

	has_secure_password
	ROLES  = { member: 'Member', pending: 'Pending',  moderator: 'Moderator', admin: 'Admin' }
	
	attr_accessible :username, :email, :password,:password_confirmation, :first_name, 
	:last_name, :role, :activation_token, :confirmed, :remember_token,
	:bio, :occupation, :location, :reset_token, :reset_token_expiration
	
	#Validations
	validates_presence_of :username, :email
	validates_presence_of :password, :password_confirmation, on: :create 
	validates_uniqueness_of :email, :username, case_sensitive: false 
	validates :username, format: {with: /^[A-Za-z0-9_-]*$/}, length: {minimum: 5, maximum: 15}
	validates :email, format: { with: /^[A-Z_a-z0-9-]+(\.[A-Z_a-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,4})$/ }
	validates_format_of :password, :password_confirmation, with: /[\d\w\\\!#$@%^&*()\+-='\[\]:>?"{}]*/, allow_blank: true
	validates_length_of :password, :password_confirmation, minimum: 6, maximum: 32
	validates_format_of :first_name, :last_name, with: (/[\w]*/), allow_blank: true 
	validates_length_of :first_name, :last_name, maximum: 32

	validates :role, inclusion: { in: ROLES.values }

	#Add necessary tokens 
	before_create :add_activation_token  
	before_create :add_remember_token
	before_save :sanitize_fields
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
	def sanitize_fields
		fields_to_sanitize = %w( :bio :occupation :location )
		fields_to_sanitize.each do |field|
			field = sanitize(field) if field
		end
	end
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