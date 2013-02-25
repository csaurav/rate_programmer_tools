class ResetPasswordController < ApplicationController


	#GET /forgot_password
	def new
	end

	#POST /forgot_password
	def create
		@user = User.find_by_username(params[:identifier]) || User.find_by_username(params[:email])
		@user.add_reset_token if @user
		flash[:info] = "An email with reset instructions was sent for that user"
		redirect_to root_path
	end

	#MATCH /reset_password/:reset_token
	def edit
	end


	def update
	end
end
