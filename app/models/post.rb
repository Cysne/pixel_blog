# frozen_string_literal: true

# model de Posts
class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  acts_as_commentable
  has_one_attached :image
  validates :title, :content, :image, presence: true
end
