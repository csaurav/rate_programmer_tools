class UsersController < ApplicationController
  before_filter :logged_in?, only: [:edit,:update,:resend_activation]
  before_filter :not_logged_in?, only: [:new,:create]

  #GET /user/new
  #Sign up form
  def new
  	@user = User.new
  end

  def resend_activation
    if !@current_user.confirmed && !@current_user.activation_token.nil? 
      ActivationMailer.activation_email(@current_user).deliver
      flash[:notice] = "The activation email was resent to #{@current_user.email} <br/>
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
      flash[:success] = 'Registeration was successful.'
      redirect_to controller: 'home', action: 'search'
    else
      render :new
    end
  end

  #GET /user/activate/:activation_token
  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    if @user
      @user.update_attributes confirmed: true, activation_token: nil
      flash[:notice] = "Your account has been successfully activated"
    else
      flash[:error] = "Sorry! We couldn't find you in our database!<br /> 
      Maybe this account was already activated?<br /> 
      If the problem persists please contact an administrator"
      redirect_to controller: 'home', action: 'search' and return
    end
    redirect_to login_path  
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
    render 'edit'
  end

end