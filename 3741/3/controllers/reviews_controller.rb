# frozen_string_literal: true

require_relative 'main_controller'

class ReviewsController < MainController
  namespace '/reviews' do
    post '/:place_id/new' do
      place = Place.find(params[:place_id])
      if user_logged?
        show_message review_validation(place)
      else
        show_message 'not login in'
      end
      redirect "/places/#{place.id}"
    end
  end

  private

  def review_validation(place)
    review = create_review(place)
    'need more text' unless review.persisted?
  end

  def create_review(place)
    Review.create(stars: params[:stars].to_i,
                  comment: params[:comment],
                  place_id: place.id,
                  user_id: actual_user.id)
  end
end
