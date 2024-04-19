class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  acts_as_commentable
  has_one_attached :image
  validates :title, :content, :image, presence: true

  before_destroy :destroy_comments

  private

  def destroy_comments
    comments.each do |comment|
      comment.destroy
    end
  end
end
