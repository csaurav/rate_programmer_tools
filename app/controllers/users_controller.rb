class UsersController < ApplicationController
  #GET /users
  #User directory Maybe?
  # def index
  # end

  #GET /users/new
  #Sign up form
  def new
  	@user = User.new
  end

  #POST /users/
  def create
    @user = User.new params[:user]
    if @user.save
      flash[:notice] = 'Registeration was successful.'
      redirect_to controller: 'home', action: 'search'
    else
      render :new
    end
  end

  #GET /users/activate/:auth_token
  def activate
    @user = User.find_by_auth_token(params[:auth_token])
    if @user
      @user.update_attributes confirmed: true, auth_token: nil
      flash[:notice] = "Your account has been successfully activated"
    else
      flash[:error] = "Sorry! We couldn't find you in our database!<br /> 
      Maybe this account was already activated?<br /> 
      If the problem persists please contact an administrator"
      redirect_to controller: 'home', action: 'search' and return
    end
      redirect_to login_path  #RENDER LOGIN PAGE --------------------- FIX WHEN LOGIN MADE
  end

  #GET /users/:id
  def show
    @user = User.find_by_username params[:username]
    render :profile
  end

  # GET /users/:id/edit
  # Only a form to update profile
  def edit 
  end

  # PUT /users/:id/
  def update
  end

  # DELETE /users/:id
  def destroy
  end


end