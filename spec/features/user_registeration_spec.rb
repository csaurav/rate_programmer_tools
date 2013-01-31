require 'spec_helper'
feature 'A user should be able to sign up' do 
	scenario 'when a user clicks sign up on the home page' do 
		visit '/'
		click_link 'Sign Up'
		fill_in 'user_email', with: 'test_email@gmail.com'
		fill_in 'user_username', with: 'test_username'
		fill_in 'user_first_name', with: 'Harry'
		fill_in 'user_last_name', with: 'Potter'
		['user_password','user_password_confirmation'].each do |field|
			fill_in field, with: 'a_password'
		end
		click_button 'Register'
		page.should have_content "Registeration was successful"
	end
end