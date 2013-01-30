class User < ActiveRecord::Base 
	has_secure_password
	attr_accessible :username, :email, :password,:password_confirmation
	attr_accessible :first_name, :last_name,:role, :auth_token
	validates_presence_of :username, :email, :password, :password_confirmation
	validates_uniqueness_of :email, :username, case_sensitive: false

	validates_format_of :username, with: /^[A-Za-z0-9_-]{5,15}$/
	validates_format_of :email, with: /^[A-Z_a-z0-9-]+(\.[A-Z_a-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,4})$/

	validates :password, format: {with: /[\d\w\\\!#$@%^&*()\+-='\[\]:>?"{}]{5,32}/}
	
	validates_format_of :first_name, :last_name, with: /[A-Za-z]{0,32}/

def to_param
	username if username.present?
end

end