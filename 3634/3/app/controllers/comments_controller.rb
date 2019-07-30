class CommentsController < ApplicationController
  get '/:restaurant_id' do
    if logged_in?
      @restaurant_id = params[:restaurant_id]
      slim :'comment/comment_form'
    else
      flash[:message] = "You're not permitted to leave comment. Please, login"
      redirect '/'
    end
  end

  # get '/:id' do
  #   @comment = Comment.find_by(id: params[:id])
  #   unless @comment
  #     flash[:message] = 'There is not such comment'
  #     redirect '/'
  #   end
  #   slim :'comment/comment'
  # end
end
