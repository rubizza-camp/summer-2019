# frozen_string_literal: true

require_relative 'base_controller'
require_relative '../services/review_service'
require_relative '../services/session_service'

class ReviewController < BaseController
  include ReviewService
  include SessionService

  post '/restaurants/:id/reviews' do
    @restaurant = Restaurant.includes(:user).find_by(id: params[:id])
    unable_to_review_twice if already_reviewed?

    create_review
    approve_review
    redirect back
  end

  delete '/reviews/:id' do
    Review.find_by(id: params[:id]).destroy
    redirect back
  end
end
