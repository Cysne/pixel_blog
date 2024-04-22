class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  acts_as_commentable
  has_one_attached :image, dependent: :destroy
  validates :title, :content, :tags, presence: true

  before_destroy :destroy_comments

  def destroy_comments
    comment_threads.each do |comment|
      comment.destroy
    end
  rescue StandardError => e
    puts "Erro ao destruir comentários: #{e.message}"
  end
end
