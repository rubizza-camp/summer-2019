require_relative '../helpers/flash'
require_relative '../helpers/rating'

class ReviewsController < Sinatra::Base
  include FlashHelper
  include RatingHelper

  register Sinatra::Flash

  post '/reviews/new' do
    return if validate_review

    Review.create(user_id: session[:user].id, place_id: params['place_id'],
                  rating: params['rating'], text: params['note'])
    flash_info('Thanks for yor review!')
    redirect "/places/#{params['place_id']}"
  end
end
