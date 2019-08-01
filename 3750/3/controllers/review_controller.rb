# frozen_string_literal: true

require_relative 'base_controller'

class ReviewController < BaseController
  before '/restaurants/*' do
    halt 403 unless current_user
  end

  def restaurant
    @restaurant ||= Restaurant.find_by(id: params[:id])
  end

  def review
    @review ||= current_user.reviews.create(grade: params[:grade].to_i, text: params[:text],
                                            restaurant_id: restaurant.id)
  end

  post '/restaurants/:id/reviews' do
    unable_to_review_twice if restaurant.already_reviewed?(session[:user_id])

    if review.valid?
      review.review_approved(restaurant)
      info_message 'Review has been created'
      redirect back
    else
      error_message 'You need to enter more text before publishing'
    end
    redirect back
  end

  delete '/reviews/:id' do
    review_to_destroy = Review.find_by(id: params[:id])
    if review_to_destroy.review_owner?(current_user)
      review_to_destroy.destroy
    else
      error_message 'You are not allowed to delete reviews of other people!'
    end
    redirect back
  end

  private

  def unable_to_review_twice
    error_message 'You can post only one review'
    redirect "/#{restaurant.name}"
  end
end
