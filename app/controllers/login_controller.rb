class LoginController < ApplicationController 
	def new
		if @current_user
			flash[:error] = "You're already logged in. Log out first!"
			redirect_to root_path and return
		end
		render :login
	end
	def create
		@user = User.authenticate(params[:user])
		if @user
			session[:current_user_id] = @user.id
			@current_user =  @user
			render template: 'users/profile'
		else 
			redirect_to :login, flash: {error: "Sorry! No such username matches that password"}
		end
	end
	def destroy
		if @current_user
			session[:current_user_id] = nil
			flash[:notice] = "You have been successfully logged out"
		end
		redirect_to root_path
	end
end