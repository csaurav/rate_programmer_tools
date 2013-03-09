#	* --- NOTE --- *
# Upon adding ANY fields, if the field needs to be sanitized, 
# then in the sanitize_fields function, simply add the name of your field.
class User < ActiveRecord::Base
	has_secure_password
	ROLES  = { member: 'Member', pending: 'Pending',  moderator: 'Moderator', admin: 'Admin' }
	
	attr_accessible :username, :email, :password,:password_confirmation, :first_name, 
	:last_name, :role, :activation_token, :confirmed, :remember_token,
	:bio, :occupation, :location, :reset_token, :reset_token_expiration
	
	#Validations
	validates_presence_of :username, :email, :role, :remember_token
	validates_presence_of :password, :password_confirmation, on: :create

	validates_uniqueness_of :email, :username, case_sensitive: false
	validates_uniqueness_of :remember_token 
	
	validates :username, format: {with: /^[A-Za-z0-9_-]*$/, message: "can only contain A-Z,a-z,0-9 and underscores"}, 
	length: {minimum: 5, maximum: 15}
	validates :email, format: { with: /^[A-Z_a-z0-9-]+(\.[A-Z_a-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,4})$/ }
	validates :role, inclusion: { in: ROLES.values }
	
	validates_length_of :password, :password_confirmation, minimum: 6, maximum: 32, on: :create
	validates_length_of :first_name, :last_name, maximum: 32
	
	validates_format_of :password, :password_confirmation, with: /[\d\w\\\!#$@%^&*()\+-='\[\]:>?"{}]*/, allow_blank: true, 
	message: "Password can only contain valid symbols such as '!@#{}$%^& etc.'" 
	validates_format_of :first_name, :last_name, with: (/^[\w\s]*$/), allow_blank: true, 
	message: "Name can only contain spaces and letters" 


	#Add necessary tokens 
	before_validation :add_activation_token, on: :create  #Also Assigns default role ROLES[:pending]
	before_validation :add_remember_token, on: :create
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


	def send_reset_password_email
		add_reset_token
		UserMailer.reset_email(self).deliver 	
	end

	private
 	include ActionView::Helpers::SanitizeHelper
	def add_reset_token
		generate_token(:reset_token)
		update_attributes reset_token_expiration: 3.hours.from_now
	end

	def sanitize_fields
		fields_to_sanitize = %w( :bio :occupati-on :location )
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