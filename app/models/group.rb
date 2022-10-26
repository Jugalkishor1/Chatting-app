class Group < ApplicationRecord
	has_many :chats, dependent: :destroy
end
