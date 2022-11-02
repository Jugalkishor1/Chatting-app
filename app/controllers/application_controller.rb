class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true
	def current_user
			# binding.pry
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
		end

	def total_friends
		friends = FriendShip.where('user_id= ? OR friend_id= ?', current_user.id, current_user.id).where(status: true)
		@friendship_id = friends.pluck(:id)
		@users = User.where(id: friends.pluck(:friend_id, :user_id).flatten).where.not(id: current_user.id).count
	end

	def pending_requests
		User.includes(:friend_ships).where(friend_ships: { friend_id: current_user.id, status: false }).count
	end

	def sent_requests
		@send_requests = FriendShip.where(user_id: current_user.id).where(status: false).includes(:user, :friend).count
	end
	
	def require_login
		if current_user.nil?
			redirect_to new_session_path
		end
	end
	
	def my_friends
		friends = FriendShip.where("friend_id IN (:user) OR user_id IN (:user)", {user: current_user.id}).where(status: true).includes(:user, :friend)
  	friends_ids = friends.pluck(:friend_id, :user_id).flatten - [current_user.id]
	end	
	
	before_action :require_login

	helper_method :my_friends

	helper_method :total_friends
	helper_method :pending_requests
	
	helper_method :sent_requests

	helper_method :current_user
end
