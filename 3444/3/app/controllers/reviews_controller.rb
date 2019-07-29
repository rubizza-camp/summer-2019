class ReviewsController < ApplicationController
  get '/bars/:id/reviews/new' do
    env['warden'].authenticate!
    @bar_id = params[:id]
    erb :'comments/new'
  end

  post '/bars/:bar_id/comments/new' do
    env['warden'].authenticate!
    params.delete 'submit'
    @comment = Review.create(params)
    if @comment.save
      redirect "/bars/#{params[:bar_id]}/show"
    else
      flash[:error] = 'Check your rate or comment'
      redirect "/bars/#{params[:bar_id]}/comments/new"
    end
  end
end
