require_relative 'application_controller'

class CommentsController < ApplicationController
  post '/places/:id/comments' do
    comment = current_user.comments.create(rating: params[:rating].to_i,
                                           text: params[:text], place_id: params[:id])
    if comment.save
      flash[:success] = I18n.t(:successful_comment)
    else
      flash[:warning] = I18n.t(:bad_rating)
    end
    redirect "/places/#{params[:id]}"
  end
end
