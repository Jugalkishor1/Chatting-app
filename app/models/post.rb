class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  has_rich_text :content
end
