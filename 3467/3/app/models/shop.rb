class Shop < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates_uniqueness_of :name

  def refresh_rating
    update_column(:rating, reviews.average(:rating).round(1))
  end
end
