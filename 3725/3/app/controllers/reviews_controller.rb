class ReviewsController < ApplicationController
  post '/' do
    review = Review.create(review: params[:review],
      post_id: session[:id], user_id: session[:user_id])
    redirect 'posts/all'
  end
end
