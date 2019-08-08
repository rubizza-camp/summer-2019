class CommentsController < ApplicationController
  post '/new_comment' do
    review = Comment.create(text: params[:comment],
                            star: params[:star],
                            place_id: params[:id],
                            user_id: params[:user_id])
    valid_comment(review)

    Place.find(params[:id]).update(rating: calculate_average_rating)
    redirect "/place/#{params[:id]}"
  end

  get '/delete_session_message_show' do
    session.delete(:message)
    redirect back
  end

  private

  def valid_comment(review)
    if review.valid?
      Place.find(params[:id]).update(rating: calculate_average_rating)
    else
      session[:message] = 'You are having trouble. Try again'
      redirect "/place/#{params[:id]}"
    end
  end

  def calculate_average_rating
    average_rating = Place.find(params['id']).comments.average(:star).to_f
    average_rating.round(2)
  end
end
