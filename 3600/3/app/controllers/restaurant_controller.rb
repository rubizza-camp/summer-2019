# frozen_string_literal: true

require_relative '../../helpers/comment_helper.rb'

class RestaurantController < AppController
  include CommentsHelper

  get '/' do
    @all_restaurants = Restaurant.all
    erb :home
  end

  get '/restaurant/:name' do
    session[:place] = params[:name]
    @restaurant = Restaurant.all.find_by(name: params[:name])
    @all_comments = Comment.all
    if @restaurant
      erb :restaurant
    else
      flash[:danger] = 'No such cafe!'
      redirect '/'
    end
  end

  post '/restaurant/new-comment' do
    @restaurant = Restaurant.find_by(name: session[:place])

    add_new_comment if (negative_comment_has_text || params[:grade].to_i >= 3) && session[:user_id]
    redirect "/restaurant/#{@restaurant.name}"
  end
end
