# frozen_string_literal: true

require 'sinatra/base'

module ReviewHelper
  def create_review
    @review = Review.create(stars: params[:stars].to_i,
                            comment: params[:comment],
                            place_id: @place.id,
                            user_id: @user.id)
  end

  def review_valid?
    @review.persisted?
  end
end
