require 'spec_helper'
require 'factory_girl_helper'

feature 'User password reset' do
	let(:user) { FactoryGirl.create(:user) }

	scenario 'when a user attempts to log in, but forgets his password' do
		visit user_login_path
	end 

end