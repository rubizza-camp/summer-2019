class CommentsController < ApplicationController
  post '/restaurants/:id/comments' do
    comment = Comment.new(text: params['text'],
                          raiting: params['raiting'],
                          user_id: current_user.id,
                          restaurant_id: params[:id])
    if comment.save
      redirect back
    else

      @restaurant = Restaurant.find(params[:id])
      @error = comment.errors.messages.values.first[0]
      @comments = @restaurant.comments.includes(:user)
      erb :'restaurants/restaurant'
    end
  end
end
