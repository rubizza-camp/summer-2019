require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
#require 'pry'

set :database, 'sqlite3:db/database.sqlite3'

enable :sessions

before do
  @active_user = User.find_by(id: session[:id])

  pass if ['/login', '/logout', '/registration', '/add_review'].include? request.path_info
  session[:return_to_page] = request.path_info
end

# main page
get '/' do
  @restaurants = Restaurant.all
  erb :index
end

# registration
get '/registration' do
  erb :registration_form
end

post '/registration' do
  user = User.new(params)
  if user.save
    session[:id] = user.id
    redirect session[:return_to_page]
  else
    flash[:error] = user.errors.full_messages.join('; ')
    redirect '/registration'
  end
end

# login & logout
get '/login' do
  erb :login_form
end

post '/login' do
  user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
  if user
    session[:id] = user.id
    redirect session[:return_to_page]
  else
    flash[:error] = 'Invalid email/password combo!'
    redirect '/login'
  end
end

get '/logout' do
  session[:id] = nil
  redirect session[:return_to_page]
end

# add_review
post '/add_review' do
  review = Review.new(params)
  flash[:error] = review.errors.full_messages.join('; ') unless review.save

  redirect session[:return_to_page]
end

# restaurants_in_detail
get '/:name' do
  @restaurant = Restaurant.find_by(name: params[:name])
  @average_rating = @restaurant.reviews.average(:rating)
  erb :restaurant_in_detail
end

require './models/user'
require './models/restaurant'
require './models/review'
