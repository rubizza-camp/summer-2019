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
      redirect to "places/#{params[:id]}"
    end
  end

  get '/' do
    @places = Place.all
    erb :index
  end

  get '/places/:id' do
    @place = Place.find_by_id(params[:id])
    @place.comments.each do |comment|
      @place.rating += comment.rating
    end
    @place.update(rating: @place.rating / @place.comments.count) if @place.comments.count.positive?
    erb :'places/show'
  end
end
