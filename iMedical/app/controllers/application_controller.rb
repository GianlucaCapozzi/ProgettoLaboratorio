class ApplicationController < ActionController::Base

    include SessionsHelper

	def current_ability
		@current_ability ||= Ability.new(current_user, session)
	end
end
