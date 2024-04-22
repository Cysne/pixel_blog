class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  def self.paginated(page, per_page = 10)
    order(:name).page(page).per(per_page)
  end
end
