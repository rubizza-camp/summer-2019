class Shop < ActiveRecord::Base
  has_many :reviews

  def rating
    reviews.average(:grade).round(2)
  end
end
