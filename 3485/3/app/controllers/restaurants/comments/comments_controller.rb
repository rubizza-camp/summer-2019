class CommentsController < ApplicationController
  post '/restaurants/:id/comments' do
    comment = Comment.new(text: params['text'],
                          raiting: params['raiting'],
                          user_id: current_user.id,
                          restaurant_id: @restaurant.id)
    unless comment.save
      @restaurant = Restaurant.find(params[:id])
      @error = comment.errors.messages.values.first[0]
      @comments = @restaurant.comments.includes(:user)
    end
    erb :'restaurants/restaurant'
  end
end
