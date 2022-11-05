class Comment < ApplicationRecord
	belongs_to :user
	# belongs_to :post#, class_name: :Post, foreign_key: "post_id"

  belongs_to :parent_comment, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_comment_id, dependent: :destroy

  validates :comment, presence: true
end