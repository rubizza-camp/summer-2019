class ReviewsController < ApplicationController
  post '/shops/:id' do
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.includes(:user).order('id DESC')
    @review = @shop.reviews.new(params[:review])
    @review.user_id = session[:user_id]

    if @review.save
      @shop.refresh_rating
      @review.comment = nil
    else
      @error = @review.errors.full_messages.first
    end

    erb :shops
  end
end
