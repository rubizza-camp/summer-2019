class UpdateRating
  def self.calc(avg_rating, reviews_count, cur_rating)
    (((avg_rating * (reviews_count - 1)) + cur_rating) / reviews_count).to_f
  end
end
