class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true
		def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
		end

		def count
			friends = FriendShip.where('user_id= ? OR friend_id= ?', current_user.id, current_user.id).where(status: true)
      @friendship_id = friends.pluck(:id)
      @users = User.where(id: friends.pluck(:friend_id, :user_id).flatten).where.not(id: current_user.id).count
		end
		
		def require_login
			if current_user.nil?
				redirect_to new_session_path
			end
		end

	before_action :require_login

	helper_method :count

	helper_method :current_user
end