require 'spec_helper'
require 'faker'
describe 'User' do
	it 'has a valid email' do
		username = 'fake_username'
		password = 'some_password'
		user = User.new username: username, password: password, email: 'a_valid_email@gmail.com',
		password_confirmation: password
		user.save!

		user.email =  (Faker::Base.regexify  /^[A-Z_a-z0-9_]{5,10}@[a-zA-Z0-9]{2,5}.[a-zA-Z]{2,4}$/)
		user.should be_valid

		user.update_attributes 	email: 'notAValidEmail' 
		user.should_not be_valid
		assert user.errors.messages.include? :email

		user.email =  nil
		user.should_not be_valid
		assert user.errors.messages.include? :email

		user.email = 'Valid_Email@Gmail.Com'
		user.save!
		duplicateEmail = User.new username: 'new_user', password: password, email: 'valid_email@gmail.com',
		password_confirmation: password
		duplicateEmail.should_not be_valid
		duplicateEmail.errors.full_messages.include? "Email has already been taken"

	end

	it 'has a valid username' do
		email =  'valid_email@gmail.com'
		password = 'some_password'
		user = User.new username: 'Valid_Username', email: email, password: password,password_confirmation: password
		user.save!

		user.username =  (Faker::Base.regexify /^[a-z0-9_-]{5,15}$/)
		user.should be_valid

		#valid symbols = only underscore
		user.username =  '$@!====Invalid_Username'
		user.should_not be_valid
		assert user.errors.messages.include? :username

		#at least 5 characters
		user.username =  'hi'
		user.should_not be_valid
		assert user.errors.messages.include? :username

		#at most 15 characters
		user.username =  '1234567890123456'
		user.should_not be_valid
		assert user.errors.messages.include? :username

		#MUST have a username
		user.username =  nil
		user.should_not be_valid

		#username must be unique
		user.username =  'dupUserName'
		user.save!
		duplicate = User.new email: email, password: password, username: 'DuPUseRrName',password_confirmation: password
		duplicate.should_not be_valid
		duplicate.errors.full_messages.include? "Email has already been taken"
	end

	it 'has a valid password' do
		username = 'fake_username'
		email = 'valid_email@gmail.com'
		user = User.new username: username, email: email, password: 'test_password', password_confirmation: 'test_password'
		user.save! 

		
		nil_pass_user = User.create(username: username, email: email, password: nil, password_confirmation: nil)
		nil_pass_user.should_not be_valid
		nil_pass_user.errors.full_messages.include? "Password can't be blank"

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
		user.errors.messages.include? :password_confirmation

		#Only test for presence on create
		nil_pass_user = User.create(username: 'a_new_user', email: 'another_test_email@gmail.com', 
								password: 'test_password', password_confirmation: nil,
								)
		nil_pass_user.should_not be_valid
		nil_pass_user.errors.full_messages.include? "Password confirmation can't be blank"

	end
	it 'needs first name and last names tests. if any.'
end