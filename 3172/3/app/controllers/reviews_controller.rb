require_relative 'application_controller'

class ReviewsController < ApplicationController
  post '/places/:place_id/reviews' do
    return redirect '/login/sign_in' unless session[:identity]
    @place = Place.find(params[:place_id])
    @average_rating = @place.reviews.average('rating')
    @average_rating = @average_rating.round 2 if @average_rating

    rating = params[:rating].to_i

    new_review = @place.reviews.new
    new_review.text = params[:review_text]
    new_review.rating = rating

    if new_review.save
      redirect "/places/#{params[:place_id]}"
    else
      @error = new_review.errors.full_messages.first
      erb :place
    end
  end
end
