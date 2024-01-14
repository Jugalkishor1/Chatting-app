class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true
	before_action :configure_permitted_parameters, if: :devise_controller?

 # Custom code for current user as i first made login and registration without devise gem
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
		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password)}
  end
	
	helper_method :total_friends
	helper_method :pending_requests
	
	helper_method :sent_requests

	# helper_method :current_user
end
