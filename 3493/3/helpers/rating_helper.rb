class RatingHelper
  def self.calculate_average_rating(place_id)
    Review.where(places_id: place_id).average(:rating).round(1)
  end
end
