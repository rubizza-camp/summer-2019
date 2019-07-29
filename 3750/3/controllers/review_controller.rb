require_relative 'base_controller'
require_relative '../helpers/review_helper'

class ReviewController < BaseController
  include ReviewHelper

  post '/review/new' do
    @restaurant = Restaurant.find_by(name: session[:restaurant])
    if user_logged? && !already_reviewed?
      create_review
      info_message review_validation_info
    else
      error_message 'You must be logged in! Or you tried to publish several reviews'
    end
    redirect "/#{@restaurant.name}"
  end

  post '/review/delete' do
    review_to_delete = Review.find_by(user_id: session[:user_id])
    review_to_delete.destroy
  end
end
