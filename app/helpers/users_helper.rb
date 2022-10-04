module UsersHelper
	def find_user(user_id)
		User.find(user_id)
	end
end
