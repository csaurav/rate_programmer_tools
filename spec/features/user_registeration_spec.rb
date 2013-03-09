require 'spec_helper'
require 'pry'

def fill_signup_form options = {}
	fill_in 'user_email', with: options[:email] || 'valid.email@gmail.com'
	fill_in 'user_username', with: options[:username] || 'test_username'
	fill_in 'user_first_name', with: options[:first_name] || 'Harry'
	fill_in 'user_last_name', with: options[:last_name] || 'Potter'
	fill_in 'user_password', with: options[:password] || 'a_password'
	fill_in 'user_password_confirmation', with: options[:password_confirmation] || 'a_password'
end

def have_error message
	have_xpath("//input[@data-content=\"#{message}\"]")
end

feature 'User Sign-Up' do
	context 'when a user is logged in' do
		scenario 'when a user attempts to sign up' do 
			user = FactoryGirl.create(:user)
			visit '/user/login'
			fill_in 'user_username', with: user.username
			fill_in 'user_password', with: user.password
			click_button 'Sign in'
			visit '/user/signup'
			page.should have_content "You can't do that while you're logged in. Please logout"
		end
	end
	context 'when the user is not logged in' do
		scenario 'the user should be presented with a valid sign up form when he/she clicks sign up' do
			visit '/'
			click_link 'Sign Up'
			page.should have_content "Registration"
			page.has_xpath? '//input', count: 8
		end

		scenario 'when a user fills out a valid form' do 
			visit '/user/signup'
			fill_signup_form
			click_button 'Register'
			page.should have_content "Registration was successful"
		end
		scenario 'when a user fills out an invalid form but then fixes it' do
			visit '/user/signup'
			fill_signup_form email: 'fail', password: 'fail', password_confirmation: 'fail'
			click_button 'Register'
			page.should have_error "Email is invalid"
			page.should have_error "Password is too short (minimum is 6 characters)"
			click_button 'Register'
		end
		scenario 'when a user fills out an empty form' do 
			visit '/user/signup'
			click_button 'Register'
			page.should have_error "Email can't be blank<br>Email is invalid"
			page.should have_error "Username can't be blank<br>Username is too short (minimum is 5 characters)"
		end
	end
end