class ApplicationController < ActionController::Base

	helper_method :current_user

	before_action :verifySession

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	
	def verifySession
		if session[:type] == nil 
			#session[:type] = "Guest"
			#redirect_to root_path
		end
	end
	
end
