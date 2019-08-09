class ReviewsController < ApplicationController
  before '/shops/:id/review' do
    unless current_user
      flash[:error] = I18n.t(:unloged_in_user)
      redirect '/login'
    end
  end

  post '/shops/:id/review' do
    @review = Review.new(text: params['text'], grade: params['grade'].to_i,
                         shop_id: params[:id], user_id: current_user.id)
    flash[:error] = I18n.t(:review_error) unless @review.save
    redirect "/shops/#{params[:id]}"
  end
end
