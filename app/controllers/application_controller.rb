class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true

	# def current_user
	# 	@current_user ||= User.find(session[:user_id]) if session[:user_id]
	# 	rescue ActiveRecord::RecordNotFound
	# 		redirect_to root_path and return if @current_user.present?
	# end

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

	protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
	
	helper_method :total_friends
	helper_method :pending_requests
	
	helper_method :sent_requests

	# helper_method :current_user
end
