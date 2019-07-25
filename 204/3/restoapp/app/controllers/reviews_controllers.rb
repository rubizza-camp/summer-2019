class ReviewsController < ApplicationController
  def new; end

  def create
    @review = Review.new(review_params)
  end

  def show; end

  def edit; end

  def update; end

  private

  def review_params
    params.require(:review).permit(:restraunt_id, :user_id, :body, :mark)
  end
end
