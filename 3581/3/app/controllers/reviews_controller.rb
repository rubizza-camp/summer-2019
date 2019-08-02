class ReviewController < ApplicationController
  post '/reviews/new' do
    session!
    @review = Review.new(text: params['text'], grade: params['grade'].to_i,
                         place_id: params[:place_id], user_id: session[:user_id])
    @review.save
    redirect "/places/#{params[:place_id]}"
  end
end
