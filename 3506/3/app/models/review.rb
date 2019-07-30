class Review < ActiveRecord::Base
  validates_presence_of :rating, :comment

  belongs_to :restaurant
  belongs_to :user

  def self.count_average_rating(restaurant_id)
    where(restaurant_id: restaurant_id).average(:rating).round(2)
  end
end
