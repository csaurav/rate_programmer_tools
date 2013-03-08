require 'factory_girl'

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