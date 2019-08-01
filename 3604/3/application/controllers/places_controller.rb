class PlacesController < Sinatra::Base
  get '/places' do
    @places = Place.all
    erb :places
  end

  get '/places/:id' do
    @place = Place.find_by(params[:id])
    @reviews = Review.where(place_id: params[:id])
    @stars = place_rating unless @reviews.empty?
    erb :place
  end

  post '/reviews/:id' do
    review = Review.new(grade: params[:grade], text: params[:text],
                        place_id: params[:id], user_id: session[:user_id])
    if review.valid?
      review.save
    else
      flash[:error] = I18n.t(:incorrect_review)
    end
    redirect "/places/#{params[:id]}"
  end

  attr_reader :reviews

  private

  def place_rating
    reviews.pluck(:grade).sum.div(reviews.count)
  end
end
