class CommentController < ApplicationController
  post '/comments' do
    if params[:rating].to_i < 3 && params[:content].empty?
      flash[:message] = "You have to write what's wrong"
    else
      Comment.create(
        content: params[:content],
        rating: params[:rating].to_i,
        user_id: session[:user_id],
        restaraunt_id: params[:restaraunt_id].to_i
      )
    end
    redirect "/restaraunts/#{params[:restaraunt_id]}"
  end
end
