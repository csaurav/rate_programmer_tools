require "spec_helper"
require 'pry'
require 'factory_girl_helper'
describe UserMailer do
	context 'Activation Email' do 
		before(:each) { @user = FactoryGirl.create :user }
		it 'should automatically send an activation email to the user\'s email' do
			ActionMailer::Base.deliveries.last.to.should eq [@user.email]
		end
		it 'should have the activation link inside the email' do
			ActionMailer::Base.deliveries.last.should have_content user_activate_url(@user.activation_token)
		end
		it 'should have the subject Start Rating Programmer Tools Today!' do
			ActionMailer::Base.deliveries.last.subject.should == 'Start Rating Programmer Tools Today!'
		end
	end

	context 'Reset Password Email' do
	before(:each) do 
			@user = FactoryGirl.create :user 
			@user.send_reset_password_email
		end

		it 'should send a reset email to the user\'s email' do
			ActionMailer::Base.deliveries.last.to.should eq [@user.email]
		end
		it 'should have the reset password link inside the email' do
			ActionMailer::Base.deliveries.last.should have_content user_reset_password_url(@user.reset_token)
		end
		it 'should have the subject Reset Password - Rate Programming Tools' do
			ActionMailer::Base.deliveries.last.subject.should == 'Reset Password - Rate Programming Tools'
		end		

	end
end
