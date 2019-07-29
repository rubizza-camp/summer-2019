class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place, counter_cache: true

  after_create :update_place_rating

  private

  def update_place_rating
    new_rating = (place.rating * place.comments_count + rating) / (place.comments_count + 1)
    place.update_attribute(:rating, new_rating)
  end
end
