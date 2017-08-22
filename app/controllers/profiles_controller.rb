class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def index		
		@users = User.all
	end

	def show
		if params[:id].present?
			@user = User.find(params[:id])	
		end				
	end
end