class User < ActiveRecord::Base 
	attr_accessible :username, :email, :password
	has_secure_password
#%r-[\d\w!@#$%^&*()+-='[\]>?"{}]{5,20}-

end