module ApplicationHelper
	def find_request(friend_request)
		@abc = FriendShip.find(friend_request)
		User.find(@abc)
	end

	def friend
		@requested = current_user.friend_ships.where(status: false)
	end
end