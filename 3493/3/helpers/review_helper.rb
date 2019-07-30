class ReviewHelper
  def self.create_review(**hash)
    Review.create(hash)
  end
end
