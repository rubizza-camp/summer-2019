class PlacesController < Sinatra::Base
  get '/places' do
    @places = Place.all
    erb :places
  end

  get '/place/:id' do
    @place = Place.find_by(params[:id])
    @reviews = Review.where(place_id: params[:id])
    @stars = place_rating unless @reviews.empty?
    erb :place
  end

  post '/review/:id' do
    @review = Review.new(grade: params[:grade], text: params[:text],
                         place_id: params[:id], user_id: session[:user_id])
    @review.save
    redirect "/place/#{params[:id]}"
  end

  private

  def place_rating
    @reviews.inject(0) do |sum, review|
      sum + review.grade
    end / @reviews.count
  end
end
