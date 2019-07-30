# frozen_string_literal: true

require 'sinatra/base'

module ReviewService
  def create_review
    @user = User.find(session[:user_id])
    @review = @user.reviews.create(grade: params[:grade].to_i, text: params[:text])
    @review.restaurant_id = @restaurant.id
  end

  def already_reviewed?
    review = Review.find_by(user_id: session[:user_id])
    return false unless review
    review.restaurant_id == session[:restaurant_id]
  end

  def approve_review
    review_approved && return if @review.valid?
    error_message 'You need to enter more text before publishing'
  end

  def review_approved
    @review.save
    info_message 'Review has been created'
  end

  def unable_to_review_twice
    error_message 'You can post only one review'
    redirect "/#{@restaurant.name}"
  end
end
