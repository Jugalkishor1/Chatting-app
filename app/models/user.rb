class User < ApplicationRecord
	# validates :name, presence: true
	has_many :addresses
	accepts_nested_attributes_for :addresses
	has_many :friend_ships
	validates :name, :presence => {:message => " can't be blank." }
	validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :password, :length => {:within => 3..20}
	# scope :all_except, ->(user) { where.not(id: user) }
end