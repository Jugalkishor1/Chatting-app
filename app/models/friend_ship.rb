class FriendShip < ApplicationRecord
	self.table_name = "friendships"
	belongs_to :user
	belongs_to :friend, class_name: :User
	# scope :all_except, ->(friendShip) { where.not(status: true) }
end
