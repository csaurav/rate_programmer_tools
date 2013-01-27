require 'spec_helper'
require 'faker'
describe 'User' do
	it 'has a valid email' do
		username = Faker::Name.first_name + '_' +Faker::Name.last_name
		password = 'some_password'
		user = User.create username: username, password: password

		user.update_attributes email: (Faker::Base.regexify  /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/ )				
		user.should be_valid

		user.update_attributes 	email: 'notAValidEmail' 
		user.should_not be_valid

		user.update_attributes email: nil
		user.should_not be_valid
	end

	it 'has a valid username' do
		email =  (Faker::Base.regexify  'valid_email@gmail.com')
		password = 'some_password'
		user = User.create email: email, password: password

		user.update_attributes username: (Faker::Base.regexify /^[a-z0-9_-]{5,15}$/)
		user.should be_valid

		#valid symbol only underscore
		user.update_attributes username: '$@!====invalid_username'
		user.should_not be_valid

		#at least 5 characters
		user.update_attributes username: 'hi'
		user.should_not be_valid

		#at most 15 characters
		user.update_attributes username: '012345678912356'
		user.should_not be_valid

		#MUST have a username
		user.update_attributes username: nil
		user.should_not be_valid
	end

	it 'has a valid password' do
		
	end
end