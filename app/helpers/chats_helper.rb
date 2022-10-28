module ChatsHelper
	def get_chat_name(user_id)
		User.find(user_id.first).name
	end
end
