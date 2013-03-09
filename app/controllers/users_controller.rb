class UsersController < ApplicationController
	before_filter :must_be_logged_in, only: [:edit,:update,:resend_activation]
	before_filter :must_not_be_logged_in, only: [:new,:create]

  #GET /user
  def index
  	@user = current_user
  	render :show
  end

  #GET /user/new
  #Sign up form
  def new
  	@user = User.new
  end

  #GET resend_activation/:username
  def resend_activation
  	unless current_user.confirmed && current_user.activation_token.nil? 
  		UserMailer.activation_email(current_user).deliver
  		flash[:notice] = "The activation email was resent to #{current_user.email} <br/>
  		Be sure to check your spam or trash folder."
  	else
  		flash[:error] = "This account has already been activated"
  	end
  	redirect_to root_path
  end


  #POST /user/
  def create
  	@user = User.new params[:user]
  	if @user.save
  		flash[:success] = 'Registration was successful'
  		redirect_to controller: 'home', action: 'index'
  	else
  		render :new
  	end
  end

  #GET /user/activate/:activation_token
  def activate
  	@user = params[:activation_token] ? User.find_by_activation_token(params[:activation_token]) : nil
  	if @user
  		@user.update_attributes confirmed: true, activation_token: nil
  		flash[:notice] = "Your account has been successfully activated"
  	else
  		flash[:error] = "Sorry! We couldn't find you in our database!<br /> 
  		Maybe this account was already activated?<br /> 
  		If the problem persists please contact an administrator"
  		redirect_to controller: 'home', action: 'search' and return
  	end
  	redirect_to user_login_path  
  end

  #GET /user/profile/:username
  def show
  	@user = User.find_by_username(params[:username]) if params[:username]
  end

  #GET /user/settings
  def edit
  end			  


  #PUT /user
  def update
  	if current_user && params[:user][:current_password] && 
  		User.authenticate(current_user.username, params[:user][:current_password])
  		[:email,:first_name,:last_name,:password,:password_confirmation,:location,:occupation,:bio].each do |field|
  			current_user.assign_attributes field => params[:user][field] if !params[:user][field].empty?
  		end
  		if !current_user.save
  			flash.now[:error] = "Oops. Looks like there were some errors"
  		else
  			flash.now[:success] = "Changes made successfully" 
  		end
  	else
  		flash.now[:error] = "That password does not match this account" 
  	end
  	render :edit
  end
end