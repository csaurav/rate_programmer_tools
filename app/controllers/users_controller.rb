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
    if @user.valid?
      @user.update_attributes role: Roles[:member], auth_token: SecureRandom.hex(20) 
      ActivationMailer.activation_email(@user)
      redirect_to controller: 'home', action: 'search'
    else
      render :new
    end
  end

  #GET /users/:id
  def show
    @user = User.find_by_username params[:id]
    render :profile
  end

  # GET /users/:id/edit
  # Only a form to update profile
  def edit
    # return an HTML form for editing a specific message
  end

  # PUT /users/:id/
  def update
    # find and update a specific message
  end

  # DELETE /users/:id
  def destroy
    # delete a specific message
  end

  #GET /users/activate
end