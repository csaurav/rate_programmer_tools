class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user, :check_activation

  private
  def current_user
  	@current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def check_activation
    if current_user && !@current_user.confirmed?
      flash.now[:activate] = "Please activate your account to gain full functionality.<br />
      Didn't recieve the activation email? 
      #{view_context.link_to "Click here to resend it", 
      resend_activation_user_path(@current_user.username)}"
    end
  end

  def logged_in?
    #Add redirect where they came from functionality in future
    if current_user.nil?
      flash[:error] = "You must be logged in to do that!"
      redirect_to login_path 
    end
  end
 def not_logged_in?
   if !current_user.nil?
     flash[:error] = "You can't do that while you're logged in. Please logout"
     redirect_to root_path  
   end
 end
end
