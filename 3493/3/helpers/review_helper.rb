module ReviewHelper
  def create_review(title, description, place_id, user_id, rating)
    Review.create(title: title, description: description,
                  places_id: place_id, users_id: user_id,
                  rating: rating)
  end
end