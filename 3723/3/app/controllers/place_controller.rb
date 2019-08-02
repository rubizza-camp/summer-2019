class PlaceController < ApplicationController
  post '/places/:id' do
    @comment = Comment.create(
      title: params[:title],
      rating: params[:rating],
      place_id: params[:id],
      user_id: current_user.id
    )
    if @comment.valid?
      place.update(rating: place.comments_rating)
      redirect to "places/#{params[:id]}"
    else
      flash[:notice] = 'You must fill all forms'
      redirect to "/places/#{params[:id]}"
    end
  end

  get '/' do
    @places = Place.all
    erb :index
  end

  get '/places/:id' do
    @place = Place.find(params[:id])
    erb :'places/show'
  end

  private

  def place
    @place ||= Place.find_by_id(params[:id])
  end
end
