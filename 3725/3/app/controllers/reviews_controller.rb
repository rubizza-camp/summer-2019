require 'pry'

class ReviewsController < ApplicationController

  post '/' do
    binding.pry
    @review = Review.new(params[:review])
    @review.post_id = session[:id]
    @review.save
    redirect 'posts/all'
  end

end
