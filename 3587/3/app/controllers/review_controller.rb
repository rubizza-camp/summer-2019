class ReviewsController < ApplicationController
  get '/new_review/:id' do
    if User.find(session[:user_id])
      @reviews = Review.create(text: params['text'], grade: params['grade'].to_i,
                               shop_id: params[:id], user_id: session[:user_id])
      @reviews.save
      redirect "/shop/#{params[:id]}"
    else
      flash[:error] = I18n.t(:unregistered_user)
    end
  end
end
