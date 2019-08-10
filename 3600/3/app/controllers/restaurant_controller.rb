# frozen_string_literal: true

# rubocop:disable Metrics/LineLength

class RestaurantController < AppController
  include CommentsHelper

  get '/' do
    @all_restaurants = Restaurant.all
    erb :home
  end

  get '/restaurant/:id' do
    @restaurant = Restaurant.find_by(id: params[:id])
    @all_comments = Comment.all
    if restaurant
      erb :restaurant
    else
      flash[:danger] = 'No such cafe!'
      redirect '/'
    end
  end

  post '/restaurant/:id/comment/' do
    restaurant = Restaurant.find_by(id: params[:id])

    add_new_comment(restaurant)
    redirect "/restaurant/#{restaurant.name}"
  end

  def add_new_comment(restaurant)
    current_user.comments.create(grade: params[:grade].to_i, text: params[:text], restaurant_id: restaurant.id)
  end
end
# rubocop:enable Metrics/LineLength
