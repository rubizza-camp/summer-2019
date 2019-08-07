class ReviewsController < ApplicationController
  post '/' do
    Review.create(comment: params[:comment], post_id: params[:id], user_id: session[:user_id])
    redirect 'posts/all'
  end
end
