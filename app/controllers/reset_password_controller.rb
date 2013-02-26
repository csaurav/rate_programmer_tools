class ResetPasswordController < ApplicationController


	#GET /forgot_password
	def new
	end

	#POST /forgot_password
	def create
		@user = User.find_by_username(params[:identifier]) || User.find_by_username(params[:email])
		if @user
			@user.add_reset_token 
			flash[:info] = "An email with reset instructions was sent for that user"
		else
			flash[:error] = "No such user found!"
		end
		redirect_to root_path
	end

	#MATCH /reset_password/:reset_token
	def edit
	end


	def update
	end
end
