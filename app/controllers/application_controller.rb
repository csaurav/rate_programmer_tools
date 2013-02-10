class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user, :check_activation
  private
  def current_user
  	@current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end
  def check_activation
  	if @current_user && !@current_user.confirmed?
  		flash.now[:activate] = "Please activate your account to gain full functionality.<br />
  		Didn't recieve the activation email? <a href='#'>Click here to resend it</a>"
  	end
  end
end
