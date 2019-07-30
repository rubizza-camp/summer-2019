class ReviewController < ApplicationController
  post '/new_review/:id' do
    session!
    @review = Review.new(text: params['text'], grade: params['grade'].to_i,
                         place_id: params[:id], user_id: session[:user_id])
    if @review.valid?
      @review.save
    else
      flash[:error] = I18n.t(:blank_review)
    end
    redirect "/place/#{params[:id]}"
  end
end
