class ReviewController < ApplicationController
  post '/reviews/' do
    session!
    @review = Review.new(text: params['text'], grade: params['grade'].to_i,
                         place_id: params[:place_id], user_id: session[:user_id])
    @reviews = Review.joins(:user).last(10)
    if @review.valid?
      @review.save
    else
      flash[:error] = I18n.t(:blank_review)
    end
    redirect back
  end
end
