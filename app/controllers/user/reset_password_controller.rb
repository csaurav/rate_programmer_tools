class User::ResetPasswordController < ApplicationController


	#GET /forgot_password
	def new
	end

	#POST /forgot_password
	def create
		if @user = User.find_by_username(params[:identifier]) || User.find_by_username(params[:identifier])
			@user.send_reset_password_email
			flash[:info] = "An email with reset instructions was sent for that user"
			redirect_to root_path
		else
			flash.now[:error] = "No such user found!"
			render :new 
		end
	end

	#MATCH /reset_password/:reset_token
	def edit
		@user = params[:reset_token] ? User.find_by_reset_token(params[:reset_token]) : nil 
		can_change_password? @user #On fail, won't return - will just redirect
	end


	def update
		@user = params[:user][:reset_token] ? User.find_by_reset_token(params[:user][:reset_token]) : nil 
		can_change_password?  @user #On fail, won't return - will just redirect
		@user.assign_attributes password: params[:user][:password], password_confirmation: params[:user][:password_confirmation] 
		if @user.save && !params[:user][:password].empty?
			flash[:success] = "Password was changed successfully"
			@user.update_attributes reset_token: nil, reset_token_expiration: nil
			redirect_to root_path
		else 
			flash.now[:error] = "Oops! looks like there were some errors."
			@user.errors.add(:password,"can't be blank!") if @user &&  params[:user][:password].empty?
			render :edit
		end
	end

	private
	def can_change_password? user
		if user && user.reset_token_expiration > Time.now
			return
		else
			flash[:error] = "Uh-oh! Looks like that reset token is incorrect or expired.
			#{view_context.link_to "Click Here", user_forgot_password_path} to send a new one"
		end
		redirect_to root_path #on fail
	end
end
