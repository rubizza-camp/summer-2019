require 'pry'

class CommentsController < ApplicationController
  get '/comments/:restaurant_id' do
    if logged_in?
      @restaurant_id = params[:restaurant_id]
      slim :'forms/leave_comment'
    else
      flash[:message] = "You're not permitted to leave comment. Please, login"
      redirect '/'
    end
  end

  post '/comments/post/:restaurant_id' do
    @user = User.find(session[:user_id])
    @comment = Comment.new(
      mark: params[:mark].to_i,
      annotation: params[:annotation],
      restaurant_id: params[:restaurant_id],
      user_id: @user.id
    )

    if @comment.bad_mark? && @comment.empty?
      flash[:message] = 'Please, tell us why this low mark?'
      redirect "/comments/#{params[:restaurant_id]}"
    else
      @comment.save!
      redirect "/restaurants/#{params[:restaurant_id]}"
    end
  end
end
