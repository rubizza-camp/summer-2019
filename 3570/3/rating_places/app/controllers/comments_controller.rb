require_relative 'application_controller'

class CommentsController < ApplicationController
  post '/places/:id/comments' do
    comment = current_user.comments.create(rating: params[:rating].to_i,
                                            text: params[:text], place_id: params[:id])
    flash[:notice] = 'Оценка очень низкая. Оставьте свой отзыв' unless comment.save
    redirect "/places/#{params[:id]}"
  end
end
