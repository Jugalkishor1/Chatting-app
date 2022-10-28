class Group < ApplicationRecord
	has_many :chats, dependent: :destroy
	validates :g_name, presence: true
end
