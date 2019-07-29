require_relative 'base_controller'

class CommentsController < BaseController
  post '/places/:id/comments/new' do
    if params[:rating].to_i < 3 && params[:text].blank?
      flash[:notice] = 'Оценка очень низкая. Оставьте свой отзыв'
    else
      @user = User.find(session[:user_id])
      @comment = @user.comments.create(rating: params[:rating].to_i,
                                       text: params[:text], place_id: params[:id])
    end
    redirect "/places/#{params[:id]}"
  end
end
