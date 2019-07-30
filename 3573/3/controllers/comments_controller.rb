class CommentsController < ApplicationController
  post '/comments' do
    Comment.create(text: params[:comment],
                   star: params[:star],
                   place_id: params[:id],
                   user_id: params[:user_id])
    Place.find(params[:id]).update(rating: calculate_average_rating)
    redirect_back
  end

  private

  def calculate_average_rating
    Place.find(params['id']).comments.average(:star).to_f
  end
end

