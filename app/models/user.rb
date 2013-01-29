class User < ActiveRecord::Base 
	has_secure_password
	attr_accessible :username, :email, :password,:password_confirmation
	
	validates :username, presence: true, 
											 format: {with: /^[a-z0-9_-]{5,15}$/},
											 uniqueness: true
	validates :password, presence: true,
											 format: {with: /[\d\w\\\!#$@%^&*()\+-='\[\]:>?"{}]{5,32}/},
											 confirmation: true
	validates :password_confirmation, presence: true 

	validates :email,  presence: true,
									 	 format: {with: /^[A-Z_a-z0-9-]+(\.[A-Z_a-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,4})$/},
									 	 uniqueness: true


	before_validation do
		self.email.downcase! if self.email
		self.username.downcase! if self.username
	end


	before_save do
		self.email.downcase! if self.email
	end
end