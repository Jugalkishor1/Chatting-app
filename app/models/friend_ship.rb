class FriendShip < ApplicationRecord
	self.table_name = "friendships"
	
	belongs_to :user
	belongs_to :friend, class_name: :User, foreign_key: "friend_id"
	# scope :all_except, ->(friendShip) { where.not(status: true) }

	def self.search(search)
 		if search
   		User.joins(:addresses).where(['name LIKE ? OR city LIKE ? OR user_id LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
 		end
	end


	after_save :create_group

	private
	def create_group
		@group = Group.find_or_create_by(created_by: self.user.id, group_type: "personal",
			grp_members: [self.user.id , self.friend_id], g_name: "nothing")
	end

end
