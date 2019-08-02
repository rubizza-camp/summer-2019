class ReviewsController < ApplicationController
  post '/new_review' do
    if session[:user_id] && User.find(session[:user_id])
      @reviews = Review.create(text: params['text'], grade: params['grade'].to_i,
                               shop_id: session[:shop_id], user_id: session[:user_id])
      if @reviews.valid? && @reviews.save
        redirect "/shop/#{session[:shop_id]}"
      else
        flash[:error] = I18n.t(:review_error)
      end
    else
      flash[:error] = I18n.t(:unregistered_user)
    end
  end
end
