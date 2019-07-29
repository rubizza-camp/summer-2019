# frozen_string_literal: true

module CommentsHelper
  def add_new_comment_db
    @user = User.find(session[:user_id])
    @comment = @user.comments.create(grade: params[:grade].to_i, text: params[:text])
    @comment.restaurant_id = @restaurant.id
    @comment.save
  end

  def logged_in?
    return true if session[:user_id]

    flash[:danger] = 'You must be logged in!'
    false
  end

  def negative_comment_has_text
    return true if params[:grade].to_i < 3 && !params[:text].empty?
    return true if params[:grade].to_i >= 3

    flash[:danger] = 'Negative comment must contain any text'
    redirect "/restaurant/#{@restaurant.name}"
  end
end
