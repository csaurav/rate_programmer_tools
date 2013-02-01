class LoginController < ApplicationController 
	def new
		render :login
	end
	def create
		user = User.authenticate(params[])
		redirect_to root_path
	end
end