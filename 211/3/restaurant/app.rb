# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?
require 'sinatra/form_helpers'
require 'sinatra/flash'

enable :sessions
set :database, "sqlite3:restaurant.sqlite3"


get '/' do
  erb :index, :layout => :layout
end

get '/users' do
  @users = User.all
  erb :'users/index', :layout => :layout
end

get '/restaurants' do
  @rest = Restaurant.all
  erb :'restaurants/index', :layout => :layout
end

get '/restaurants/:id' do
  @rest = Restaurant.find(params[:id])
  erb :'restaurants/show', :layout => :layout
end

post '/reviews/create' do
	@review = Review.new(mark: params[:mark], description: params[:description], user_id: params[:user_id], restaurant_id: params[:restaurant_id])
	if @review.save
		redirect "/restaurants/#{params[:restaurant_id]}"
	else
	  flash[:error] = @review.errors.full_messages
	  redirect "/restaurants/#{params[:restaurant_id]}"
    end
	redirect "/restaurants/#{params[:restaurant_id]}"
end

get '/reviews' do
  @reviews = Review.all
  erb :'reviews/index', :layout => :layout
end


require_relative './models/user.rb'
require_relative './models/restaurant.rb'
require_relative './models/review.rb'

