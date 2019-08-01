class Comment < ActiveRecord::Base
  INVALID_RATING_VALUE = 2
  belongs_to :user
  belongs_to :place, counter_cache: true
  validates :text, presence: true, length: { minimum: 10 }, if: :invalid_rating?

  after_create :update_place_rating

  private

  def update_place_rating
    new_rating = (place.rating * place.comments_count + rating) / (place.comments_count + 1)
    place.update_attribute(:rating, new_rating)
  end


  def invalid_rating?
    rating <= INVALID_RATING_VALUE
  end
end
