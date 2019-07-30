require_relative 'application_controller'

class ReviewsController < ApplicationController
  post '/places/:place_id/reviews' do
    return redirect '/login/sign_in' unless session[:identity]
    @place = Place.find(params[:place_id])
    @average_rating = @place.reviews.average('rating')
    @average_rating = @average_rating.round 2 if @average_rating

    hh = { review_text: 'Enter text review',
           rating:      'Enter rating' }
    @error = hh.select { |key| params[key] == '' }.values.join(', ')
    return erb :place if @error != ''

    rating = params[:rating].to_i
    if rating < 1 || rating > 5
      @error = 'Enter rating 1-5'
      return erb :place
    end

    new_review = @place.reviews.new
    new_review.text = params[:review_text]
    new_review.rating = rating
    new_review.save

    redirect "/places/#{params[:place_id]}"
  end
end
