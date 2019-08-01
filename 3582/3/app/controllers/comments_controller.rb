class CommentsController < ApplicationController
  post '/comments' do
    if params[:rating].to_i < 3 && params[:content].empty?
      flash[:message] = I18n.t(:empty_comment_content)
    else
      Comment.create(
        content: params[:content],
        rating: params[:rating].to_i,
        user_id: session[:user_id],
        restaurant_id: params[:restaurant_id].to_i
      )
    end
    redirect "/restaurants/#{params[:restaurant_id]}"
  end
end
