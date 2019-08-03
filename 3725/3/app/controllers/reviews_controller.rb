class ReviewsController < ApplicationController
  post '/' do
    @review = Review.new(params[:review])
    @review.post_id = session[:id]
    @review.user_id = session[:user_id]
    @review.save
    redirect 'posts/all'
  end
end
