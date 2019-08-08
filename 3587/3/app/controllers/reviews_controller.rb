class ReviewsController < ApplicationController
  post '/shops/:id/review' do
    if current_user
      @review = Review.new(text: params['text'], grade: params['grade'].to_i,
                           shop_id: params[:id], user_id: session[:user_id])
      if @review.save
        redirect "/shops/#{params[:id]}"
      else
        flash[:error] = I18n.t(:review_error)
      end
    else
      flash[:error] = I18n.t(:unloged_in_user)
    end
    erb :login
  end
end
