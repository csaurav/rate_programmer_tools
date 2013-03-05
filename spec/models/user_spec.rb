require 'spec_helper'
require 'shoulda-matchers'	
require 'faker'
require 'pry'
require 'shoulda'



describe User do
	
	it 'has a valid email' do 	
		should validate_presence_of(:email) 
		should validate_uniqueness_of(:email)
		
		user =  User.new email: Faker::Base.regexify(/^[A-Za-z0-9_]{5,10}@[A-Za-z0-9]{2,5}.[A-Za-z]{2,4}$/)
		user.should have(:no).error_on(:email)

		should_not allow_value("notAValidEmail").for(:email)
	end

	it 'has a valid username' do
		should validate_presence_of(:username)
		should validate_uniqueness_of(:username)

		user =  User.new username: Faker::Base.regexify(/^[a-z0-9_-]{5,15}$/)
		user.should have(:no).error_on(:username)

		#valid symbols = only underscore
		should_not allow_value('$@!====Invalid_Username').for(:username)

		#at least 5 characters
		should ensure_length_of(:username).is_at_least(5).is_at_most(15)
		should_not allow_value('hi').for(:username)
		should_not allow_value('12345678901234567890').for(:username)

	end

	it 'has a valid password and passowrd confirmation' do
		should validate_presence_of(:password)
		should validate_presence_of(:password_confirmation)

		should validate_confirmation_of(:password)
		
		#Valid password symbols.
		should allow_value('!@#$%^&*()-_=+{}[]:";\\\'<>,.?/').for(:password)
		should allow_value('!@#$%^&*()-_=+{}[]:";\\\'<>,.?/').for(:password_confirmation)

		#Password atleast 6 characters long and atmost 32 characters 
		should ensure_length_of(:password).is_at_least(6).is_at_most(32) 
		should ensure_length_of(:password_confirmation).is_at_least(6).is_at_most(32) 
		should_not allow_value('1234').for(:password)
		should_not allow_value('-'*45).for(:password)
		should_not allow_value('1234').for(:password_confirmation)
		should_not allow_value('-'*45).for(:password_confirmation)
	end


	it 'has a valid first and last name' do
		should allow_value('Jane').for(:first_name)
		should allow_value('Doe').for(:last_name)

		#Only Letters and numbers and hyphens allowed
		should_not allow_value('@!>::<>').for(:first_name)
		should_not allow_value('@@@@@@@').for(:last_name)

		#Length at most 32 characters
		should ensure_length_of(:first_name).is_at_most(32)
		should ensure_length_of(:last_name).is_at_most(32)
		should_not allow_value('a'*45).for(:first_name)
		should_not allow_value('a'*45).for(:last_name)
	end
	
	it 'has a valid role' do
		should validate_presence_of(:role)
		User::ROLES.values.each do |valid_role_type| 
			should allow_value(valid_role_type).for(:role)
		end
	end

	it 'should have a remember token' do 
		# binding.pry
		should validate_presence_of(:remember_token) 
		should validate_uniqueness_of(:remember_token)
	end
end