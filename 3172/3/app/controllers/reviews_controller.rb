require_relative 'application_controller'

class ReviewsController < ApplicationController
  post '/places/:place_id/reviews' do
    return redirect '/login/sign_in' unless session[:identity]
    new_review = Review.new(
      text: params[:review_text],
      rating: params[:rating],
      user: User.find(session[:identity]),
      place: Place.find(params[:place_id])
    )
    return redirect "/places/#{params[:place_id]}" if new_review.save
    @place = Place.find(params[:place_id])
    @error = new_review.errors.full_messages.first
    erb :place
  end
end
