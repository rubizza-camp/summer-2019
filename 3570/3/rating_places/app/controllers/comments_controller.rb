require_relative 'application_controller'

class CommentsController < ApplicationController
  post '/places/:id/comments' do
    @comment = current_user.comments.create(rating: params[:rating].to_i,
                                   text: params[:text], place_id: params[:id])
    unless @comment.save
        flash[:notice] = 'Оценка очень низкая. Оставьте свой отзыв'
    end
    redirect "/places/#{params[:id]}"
  end
end
