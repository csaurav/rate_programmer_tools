class LoginController < ApplicationController 
	
	#GET /login
	def new
		if @current_user
			log_user_out
			redirect_to root_path and return
		end
		render :login
	end

	#POST /login
	def create
		@user = User.authenticate(params[:user][:username],params[:user][:password])
		if @user
			if params[:remember_me]  # -- Susceptible to cookie jacking?
				cookies.permanent[:remember_token] = @user.remember_token
			else
				cookies[:remember_token] = @user.remember_token
			end
			@current_user =  @user
			redirect_to root_path
		else 
			redirect_to :login_user, flash: {error: "Sorry! No such username matches that password"}
		end
	end

	#MATCH /logout
	def destroy
		if @current_user #Assuming @current_user always checks for login
			log_user_out
			flash[:success] = "You have been successfully logged out"
		end
		redirect_to root_path
	end

	private 
	
	def log_user_out
		cookies.delete(:remember_token) if cookies[:remember_token]
		@current_user = nil
	end

end