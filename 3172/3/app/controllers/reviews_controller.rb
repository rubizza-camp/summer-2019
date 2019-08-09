require_relative 'application_controller'

class ReviewsController < ApplicationController
  post '/places/:place_id/reviews' do
    return redirect '/sign_in' unless current_user
    @place = Place.find(params[:place_id])
    new_review = @place.reviews.build(
      text: params[:review_text],
      rating: params[:rating],
      user: current_user
    )
    flash[:notice] = new_review.errors.full_messages.join('; ') unless new_review.save
    redirect "/places/#{params[:place_id]}"
  end
end
