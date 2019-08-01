require 'pry'

class ReviewsController < ApplicationController

  post '/' do
    binding.pry
    @review = Review.new(params[:review])
    @review.save
  end

end
