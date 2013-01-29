require 'spec_helper'
require 'faker'
describe 'User' do
	it 'has a valid email' do
		username = 'fake_username'
		password = 'some_password'
		user = User.new username: username, password: password, email: 'valid_email@gmail.com',
										password_confirmation: password
		user.save!

		user.email =  (Faker::Base.regexify  /^[A-Z_a-z0-9_]{5,10}@[a-zA-Z0-9]{2,5}.[a-zA-Z]{2,4}$/)
		user.should be_valid

		user.update_attributes 	email: 'notAValidEmail' 
		user.should_not be_valid

		user.email =  nil
		user.should_not be_valid

		user.email = 'Valid_Email@Gmail.Com'
		user.save!
		duplicateEmail = User.new username: 'new_user', password: password, email: 'valid_email@gmail.com',
										password_confirmation: password
		duplicateEmail.should_not be_valid

	end

	it 'has a valid username' do
		email =  'valid_email@gmail.com'
		password = 'some_password'
		user = User.new username: 'valid_username', email: email, password: password,password_confirmation: password
		user.save!

		user.username =  (Faker::Base.regexify /^[a-z0-9_-]{5,15}$/)
		user.should be_valid

		#valid symbols = only underscore
		user.username =  '$@!====invalid_username'
		user.should_not be_valid

		#at least 5 characters
		user.username =  'hi'
		user.should_not be_valid

		#at most 15 characters
		user.username =  '1234567890123456'
		user.should_not be_valid

		#MUST have a username
		user.username =  nil
		user.should_not be_valid

		#username must be unique
		user.username =  'duplicateUsername'
		duplicate = User.new email: email, password: password, username: 'DupLiCateUsername',password_confirmation: password
		duplicate.should_not be_valid
	end

	it 'has a valid password' do
		username = 'fake_username'
		email = 'valid_email@gmail.com'
		user = User.new username: username, email: email, password: 'test_password', password_confirmation: 'test_password'
		user.save! 

		user.password =  nil
		user.should_not be_valid

		user.password =  '!@#$%^&*()_+-=;\'{}[]:"<>,.?/'
		user.password_confirmation = '!@#$%^&*()_+-=;\'{}[]:"<>,.?/'
		user.should be_valid

		user.password =  'aValidPassword1234567890'
		user.password_confirmation = 'aValidPassword1234567890'
		user.should be_valid

		user.password =  '\\password'
		user.password_confirmation = '\\password'
		user.should be_valid
	end

	it 'password confirmation works' do
		username = 'fake_username'
		email = 'valid_email@gmail.com'
		user = User.new username: username, email: email, password: 'test_password', password_confirmation: 'test_password'
		user.save!

		user.password_confirmation = 'non_working'
		user.should_not be_valid

		user.password_confirmation = nil
		user.should_not be_valid

	end
end