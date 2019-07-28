require 'sinatra/namespace'
require_relative 'base_controller'

class ReviewController < BaseController
  post '/new' do
    @place = Place.find_by(name: session[:place])
    if user_logged?
      create_review
      info_message review_validation_info
    else
      error_message 'You must be logged in!'
    end
    redirect "/#{@place.name}"
  end

  def user_logged?
    session[:user_id]
  end

  def create_review
    @user = User.find(session[:user_id])
    @review = @user.reviews.create(grade: params[:grade].to_i, text: params[:text])
    @review.place_id = @place.id
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