class Chat < ApplicationRecord
	belongs_to :group
	# belongs_to :group, class_name: :Chat, foreign_key: "group_id"
end
