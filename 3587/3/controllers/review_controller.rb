class ReviewController < ApplicationController
  post '/new_review/:id' do
    if session['user_id']
    @reviews = Review.new(text: params['text'], grade: params['grade'].to_i,
                         place_id: params[:id], user_id: session[:user_id])
    @reviews.save
    redirect "/shop/#{params[:id]}"
    else
      @error = 'Нужна авторизация'
    end
  end
end