require 'sinatra/namespace'
require_relative 'base_controller'

class ReviewController < BaseController
  post '/review/new' do
    @restaurant = Restaurant.find_by(name: session[:restaurant])
    if user_logged?
      create_review
      info_message review_validation_info
    else
      error_message 'You must be logged in!'
    end
    redirect "/#{@restaurant.name}"
  end

  post '/review/delete' do
    review_to_delete = Review.find_by(user_id: session[:user_id])
    review_to_delete.destroy
  end

  def user_logged?
    session[:user_id]
  end

  def create_review
    @user = User.find(session[:user_id])
    @review = @user.reviews.create(grade: params[:grade].to_i, text: params[:text])
    @review.restaurant_id = @restaurant.id
  end

  def review_validation_info
    if @review.valid?
      @review.save
      'Review created!'
    else
      'You need to enter more text before publishing!'
    end
  end
end