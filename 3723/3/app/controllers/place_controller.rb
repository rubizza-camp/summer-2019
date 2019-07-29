class PlaceController < ApplicationController
  post '/places/:id/new_comment' do
    if params[:title] == '' || params[:contet] == '' || params[:rating] == ''
      flash[:message] = 'You must fill all forms'
      redirect to '/places/:id/new_comment'
    else
      user = current_user
      @comment = Comment.create(
        title: params[:title],
        content: params[:contetnt],
        rating: params[:rating],
        place_id: params[:id],
        user_id: user.id
      )
      @place = Place.find_by_id(params[:id])
      if @place.comments.count.positive?
        @place.rating += @comment.rating
        @place.update(rating: @place.rating / @place.comments.count)
      else
        @place.update(rating: @comment.rating)
      end
      redirect to "places/#{params[:id]}"
    end
  end

  get '/' do
    @places = Place.all
    erb :index
  end

  get '/places/:id' do
    @place = Place.find_by_id(params[:id])
    erb :'places/show'
  end
end
