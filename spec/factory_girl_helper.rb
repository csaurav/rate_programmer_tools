require 'factory_girl'
require 'pry'
FactoryGirl.define do
	factory :user do
		email 'some_valid_email@email.com'
		username 'some_username'
		password 'valid_password'
		password_confirmation 'valid_password'

		first_name 'Joney'
		last_name  'Jane'

		bio 'California gurl - likes having fun in the sun'
		occupation 'having fun'
		location 'California'
	end
end


#The model passed must have a FactoryGirl factory defined 
def nil_check_for factory_name, attr
		user = FactoryGirl.build(factory_name) 
		user.update_attribute attr, nil #FORCE set the role to nil
		yield user
end
