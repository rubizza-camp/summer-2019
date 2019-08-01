class ReviewController < ApplicationController
  post '/new_review/:id' do
    session!
    @review = Review.create(text: params['text'], grade: params['grade'].to_i,
                            place_id: params[:id], user_id: session[:user_id])
    @review.save
    redirect "/places/#{params[:id]}"
  end
end
