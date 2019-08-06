class Shop < ActiveRecord::Base
  has_many :reviews

  def self.rating(shop)
    shop.reviews.average(:grade).round(2)
  end
end
