module CommentHelper
  def comment_to_the_cafe
    redirect 'sign_in' unless login?
    ask_about_comment unless good_mark?
    establish_comment
  end

  def establish_comment
    @user = User.find(session[:user_id])
    create_comment
    save_comment
  end

  def create_comment
    @comment = Comment.new
    @comment = @user.comments.create(grade: params[:rate].to_i, text: params[:text])
  end

  def save_comment
    @comment.place_id = session[:rest_id].to_i
    @comment.save!
  end
end
