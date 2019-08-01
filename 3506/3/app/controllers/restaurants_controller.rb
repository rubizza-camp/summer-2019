#:reek:InstanceVariableAssumption
class RestaurantsController < ApplicationController
  configure do
    set :views, 'app/views'
  end

  get '/' do
    @restaurants = Restaurant.all
    erb :index
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params['id'])
    erb :show
  end

  post '/restaurants/:id' do
    @restaurant = Restaurant.find(params['id'])
    make_review if current_user
    @restaurant.update(average_rating: Review.count_average_rating(@restaurant.id))
    redirect "/restaurants/#{@restaurant.id}"
  end

  private

  def make_review
    @review = current_user.reviews.create(rating: params[:rating].to_i,
                                          comment: params[:comment],
                                          restaurant_id: @restaurant.id)
  end
end
