require 'pry'

class CommentsController < ApplicationController
  before '/restaurants/:id/*' do
    unless current_user
      flash[:message] = "You're not permitted to leave comment. Please, login"
      redirect '/'
    end
  end

  get '/restaurants/:id/comments' do
    @id = params[:id]
    slim :'comments/new.html', layout: :'layouts/application.html'
  end

  post '/restaurants/:id/post' do
    @comment = Comment.new(
      mark: params[:mark].to_i,
      body: params[:body],
      restaurant_id: params[:id],
      user_id: current_user.id
    )
    if @comment.save
      redirect "/restaurants/#{params[:id]}"
    else
      redirect "/restaurants/#{params[:id]}/comments"
    end
  end
end
