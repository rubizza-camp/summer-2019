require_relative '../controllers/application_controller'

class CommentsController < ApplicationController
  post '/comments' do
    Comment.create(text: params[:comment],
                   star: params[:star],
                   place_id: params[:id],
                   user_id: params[:user_id])
    places = Place.find(params[:id])
    places.update(rating: places.comments.average(:star).to_f)
    redirect_back
  end
end
