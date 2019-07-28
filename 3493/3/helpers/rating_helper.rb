class RatingHelper
  def self.calculate_average_rating(plcae_id)
    reviews = Review.where(['places_id = ?', plcae_id])
    total_rating = 0
    reviews.each { |review| total_rating += review.rating }
    total_rating / reviews.count
  end
end
