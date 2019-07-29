class CommentController < ApplicationController

  get '/comments/:id/edit' do
    if is_logged_in?
      @comment = Comment.find_by_id(params[:id])
      if @comment.user_id == session[:user_id]
        erb :'comments/edit'
      else
        flash[:message] = "You cant edit it"
        redirect to '/'
      end
    else
      flash[:message] = "Login first"
      redirect to '/login'
    end
  end

  patch 'comments/:id' do
    if params[:title] == "" || params[:content] == "" || params[:rating] == ""
      flash[:message] = "Fill all forms"
    else
      @comment = Comment.find_by_id(params[:id])
      @comment.title = params[:title]
      @comment.contetnt = params[:content]
      @comment.rating = params[:rating]
      @comment.user_id = current_user.id
      @comment.save
      flash[:message] = "You updated your comment"
      redirect to '/'
    end
  end

  delete 'comments/:id/delete' do
    if is_logged_in?
      @comment = Comment.find_by_id(params[:id])
      if @comment.user_id == session[:user_id]
        @comment.delete
        flash[:message] = "Deleted"
        redirect to '/'
      end
    else
      flash[:message] = "Login first"
      redirect to '/login'
    end
  end
end
