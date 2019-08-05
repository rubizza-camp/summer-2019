require_relative '../helpers/flash'
require_relative '../helpers/rating'

class ReviewsController < Sinatra::Base
  include FlashHelper
  include RatingHelper

  register Sinatra::Flash

  post '/reviews/new' do
    return if validate_review

    review = Review.new(review_params)
    if review.save
      flash_info('Thanks for yor review!')
      redirect "/places/#{params['place_id']}"
    else
      redirect back
    end
  end

  private

  def review_params
    param_arr = %i[place_id rating text]
    param_hash = Hash[param_arr.collect { |name| [name, params[name.to_s]] }]
    param_hash[:user_id] = session[:user].id
    param_hash
  end
end
