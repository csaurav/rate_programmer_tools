require "spec_helper"
require 'pry'
require 'factory_girl_helper'
describe UserMailer do
	before(:each) { @user = FactoryGirl.create :user }
	it 'should automatically send an activation email' do
		ActionMailer::Base.deliveries.last.to.should eq [@user.email]
	end
	it 'should send the email to the user\'s email' do
		ActionMailer::Base.deliveries.last.should have_content user_activate_url(@user.activation_token)
	end
	it 'the subject should be Start Rating Programmer Tools Today!' do
		ActionMailer::Base.deliveries.last.subject.should == 'Start Rating Programmer Tools Today!'
	end
end
