class PlaceController < ApplicationController
  Tilt.register Tilt::ERBTemplate, 'html.erb'

  post '/places/:id' do
    if params[:title] == '' || params[:contet] == '' || params[:rating] == ''
      flash[:message] = 'You must fill all forms'
      redirect to '/places/:id'
    else
      @comment = Comment.create(
        title: params[:title],
        rating: params[:rating],
        place_id: params[:id],
        user_id: current_user.id
      )
      @place = Place.find_by_id(params[:id])
      rating_count(@place, @comment)
      redirect to "places/#{params[:id]}"
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

  def rating_count(place, comment)
    if place.comments.count.positive?
      place.rating += comment.rating
      place.update(rating: place.rating / place.comments.count)
    else
      place.update(rating: comment.rating)
    end
  end
end
