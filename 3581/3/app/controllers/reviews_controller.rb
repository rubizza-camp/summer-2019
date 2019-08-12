class ReviewController < ApplicationController
  before '/reviews/' do
    @place = Place.find(params[:id])
  end

  post '/reviews/' do
    @review = Review.new(text: params['text'], grade: params['grade'].to_i,
                         place_id: params[:id], user_id: session[:user_id])
    if @review.save
      redirect "/places/#{params[:id]}"
    else
      @reviews = @place.reviews.order(id: :desc)
      @error = true
      flash[:error] = I18n.t(:blank_review)
      redirect "/places/#{params[:id]}"
    end
  end
end
