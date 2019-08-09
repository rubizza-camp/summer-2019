class ReviewController < ApplicationController
  before '/reviews/' do
    redirect '/' unless Place.exists?(params[:id])
  end

  post '/reviews/' do
    session!
    @review = Review.new(text: params['text'], grade: params['grade'].to_i,
                         place_id: params[:id], user_id: session[:user_id])
    if @review.save
      redirect "/places/#{params[:id]}"
    else
      @place = Place.find(params[:id])
      @reviews = @place.reviews.order(:desc)
      @errors = true
      flash[:error] = I18n.t(:blank_review)
      erb :place
    end
  end
end
