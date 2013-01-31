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
      debugger
      ActivationMailer.activation_email(@user).deliver
      flash[:notice] = 'Registeration was successful.'
      redirect_to controller: 'home', action: 'search'
    else
      render :new
    end
  end


  def activate
    @user = User.find_by_auth_token(params[:id])
    if @user
      @user.update_attributes confirmed: true
      render @user
    else
      redirect_to controller: 'home', action: 'search'
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