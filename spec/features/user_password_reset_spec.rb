require 'spec_helper'
require 'factory_girl_helper'
require 'pry'
feature 'User Password Reset' do
	let(:user) { FactoryGirl.create(:user) }

	scenario 'when a user attempts to log in, but forgets his password' do
		visit user_login_path
		fill_in 'user_username', with: user.username
		fill_in 'user_password', with: 'wrong_password'
		click_button 'Sign in'

		page.should have_content "Sorry! No such username matches that password"
		click_link 'Forgot Password?'
		
		page.should have_content 'Reset Password'
		fill_in 'identifier', with: user.username
		click_button 'Submit'
		page.should have_content 'An email with reset instructions was sent for that user'
		
	end 	

end