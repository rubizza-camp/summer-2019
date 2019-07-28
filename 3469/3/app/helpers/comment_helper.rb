module CommentHelper
  def create_comment
    @user = User.find(session[:user_id])
    @comment = Comment.new
    @comment = @user.comments.create(grade: params[:rate].to_i, text: params[:text])
    @comment.place_id = session[:rest_id].to_i
    @comment.save!
  end
end
