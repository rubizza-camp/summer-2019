require_relative '../controllers/application_controller'

class CommentsController < ApplicationController
  post '/comments' do
    Comment.create(text: params[:comment],
                   star: params[:star],
                   place_id: params[:id],
                   user_id: params[:user_id])
    Place.find(params[:id]).update_rating
    redirect_back
  end
end
