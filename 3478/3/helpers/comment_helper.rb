module CommentsHelper
  def add_new_comment_db
    @user = User.find(session[:user_id])
    @comment = @user.comments.create(grade: params[:grade].to_i, text: params[:text])
    @comment.restaurant_id = @restaurant.id
    @comment.save
  end

  def has_text_in_comment?
    return true unless params[:text].empty?
    flash[:info] = 'You need to enter some text before publishing!'
    false
  end

  def logged_in?
    return true if session[:user_id]
    flash[:danger] = 'You must be logged in!'
    false
  end

  def negative_comment_has_text
    return true if (params[:grade].to_i < 3 && !params[:text].empty?) || params[:grade].to_i >= 3

    flash[:danger] = 'Negative comment must contain any text'
    redirect "/restaurant/#{@restaurant.name}"
  end
end
