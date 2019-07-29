require_relative 'application_controller'

class CommentsController < ApplicationController
  before do
    redirect '/' unless login?
  end

  post '/comments' do
    @comment = Comment.new(comment_params.merge(user: current_user))

    if @comment.bad_mark? && @comment.empty?
      flash[:message] = 'Specify the message.'
      redirect "/places/#{comment_params['place_id']}"
    end

    @comment.save ? flash[:success] = 'Comment created.' : flash[:error] = 'Wrong input.'

    redirect "/places/#{comment_params['place_id']}"
  end

  private

  def comment_params
    parameters.permit(:description, :mark, :place_id)
  end
end
