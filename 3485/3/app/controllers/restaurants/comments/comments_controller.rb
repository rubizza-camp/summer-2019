class CommentsController < ApplicationController
  post '/restaurants/:id/comments' do
    comment = Comment.new(text: params['text'],
                          raiting: params['raiting'],
                          user_id: session[:user_id],
                          restaurant_id: session['rest_id'])
    if comment.save

    else
      flash[:message] = comment.errors.messages.values.first[0]
    end

    redirect back
  end
end
