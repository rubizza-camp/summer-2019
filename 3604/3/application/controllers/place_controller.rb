require 'rack-flash'
class PlaceController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  use Rack::Flash

  get '/place/:id' do
    @place = Place.find_by(params[:id])
    @reviews = Review.where(place_id: params[:id])
    @stars = stars(@reviews) if @reviews.count.positive?
    erb :place
  end

  get '/review/:id' do
    erb :review_form
  end

  post '/review/:id' do
    @review = Review.new(grade: params[:grade], text: params[:text],
                         place_id: params[:id], user_id: session[:user_id])
    @review.save
    redirect '/place/' + params[:id]
  end

  private

  def stars(reviews)
    reviews.inject(0) do |sum, review|
      sum + review.grade
    end / reviews.count
  end
end
