class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true
		def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
		end

		def count
			# @count = User.find(current_user.id).friend_ships.count

		end
		
	helper_method :count

	helper_method :current_user
end