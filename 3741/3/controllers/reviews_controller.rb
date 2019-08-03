# frozen_string_literal: true

require_relative 'main_controller'

class ReviewsController < MainController
  namespace '/reviews' do
    post '/:place_id/new' do
      @place = Place.find(params[:place_id])
      if user_logged?
        show_message review_validation
      else
        show_message 'not login in'
      end
      redirect "/places/#{@place.id}"
    end
  end

  private

  def review_validation
    actual_user
    create_review
    'need more text' unless review_valid?
  end
end
