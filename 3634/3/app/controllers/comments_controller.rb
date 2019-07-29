class CommentsController < ApplicationController
  get '/:id' do
    @comment = Comment.find_by(id: params[:id])
    unless @comment
      flash[:message] = 'There is not such comment'
      redirect '/'
    end
    slim :'comment/comment'
  end
end
