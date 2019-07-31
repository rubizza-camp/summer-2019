require_relative '../controllers/application_controller'

class CommentsController < ApplicationController
  post '/comments' do
    Comment.create(text: params[:comment],
                   star: params[:star],
                   place_id: params[:id],
                   user_id: params[:user_id])
    place_update
    redirect_back
  end

  def place_update
    Place.find(params[:id]).update(rating: Place.find(params[:id]).comments.average(:star).to_f)
  end
end
