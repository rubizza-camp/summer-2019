require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'pry'

set :database, 'sqlite3:db/database.sqlite3'

enable :sessions

# authorization
def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
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
    session[:user_id] = user.id
    redirect '/'
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
    session[:user_id] = user.id
    redirect '/'
  else
    flash[:error] = 'Invalid email/password combo!'
    redirect '/login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect back
end

# add_review
post '/restaurants/:id/review' do
  if current_user
    review = Review.new({
                         user_id: current_user.id, 
                         restaurant_id: params[:id], 
                         rating: params[:rating],
                         description: params[:description]
                        })
    flash[:error] = review.errors.full_messages.join('; ') unless review.save
  else
    flash[:error] = 'Review post requested with no user currently logged in!'
  end
  redirect back
end

# restaurant
get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  @average_rating = @restaurant.reviews.average(:rating)
  erb :restaurant
end

require './models/user'
require './models/restaurant'
require './models/review'
