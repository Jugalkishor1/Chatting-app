class Chat < ApplicationRecord
	# belongs_to :group
	belongs_to :sender, class_name: 'User'
  belongs_to :group, class_name: 'Group'
	# belongs_to :group, class_name: :Chat, foreign_key: "group_id"
end
