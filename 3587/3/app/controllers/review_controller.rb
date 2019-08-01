class ReviewsController < ApplicationController
  get '/new_review/:id' do
    if session[:user_id] && User.find(session[:user_id])
      @reviews = Review.create(text: params['text'], grade: params['grade'].to_i,
                               shop_id: params[:id], user_id: session[:user_id])
      if @reviews.valid? && @reviews.save
        redirect "/shop/#{params[:id]}"
      else
        flash[:error] = I18n.t(:review_error)
      end
    else
      flash[:error] = I18n.t(:unregistered_user)
    end
  end
end
