require 'digest'
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:db/flamp.db'

class Place < ActiveRecord::Base
  has_many :reviews
end

class User < ActiveRecord::Base
end

class Review < ActiveRecord::Base
  belongs_to :place
end

configure do
  enable :sessions
end

get '/' do
  @places = Place.all
  erb :index
end

get '/login/sign_up' do
  erb :login_sign_up
end

post '/login/new' do
  hh = { user_name: 'Enter user name',
         email:     'Enter email',
         password:  'Enter password' }

  @error = hh.select { |key| params[key] == '' }.values.join(', ')
  return erb :login_sign_up if @error != ''

  user = User.find_by name: params[:user_name]
  @error = 'Username is busy' if user
  return erb :login_sign_up if @error != ''

  email = User.find_by email: params[:email]
  @error = 'E-mail is busy' if email
  return erb :login_sign_up if @error != ''

  new_user = User.new
  new_user.name = params[:user_name]
  new_user.email = params[:email]
  new_user.password = Digest::SHA1.hexdigest(params[:password])
  new_user.save

  session[:identity] = new_user.name
  redirect '/'
end

get '/login/sign_in' do
  erb :login_sign_in
end

post '/login/auth' do
  hh = { email: 'Enter e-mail',
         password:  'Enter password' }

  @error = hh.select { |key| params[key] == '' }.values.join(', ')
  return erb :login_sign_in if @error != ''

  user = User.find_by email: params[:email]
  @error = 'E-mail not found' unless user
  return erb :login_sign_in if @error != ''

  entered_password = Digest::SHA1.hexdigest(params[:password])
  @error = 'Password wrong' if user.password != entered_password
  return erb :login_sign_in if @error != ''

  session[:identity] = user.name
  redirect '/'
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/places/:id' do
  @place = Place.find(params[:id])
  @average_rating = @place.reviews.average('rating')
  @average_rating = @average_rating.round 2 if @average_rating
  erb :place
end

post '/places/:place_id/reviews' do
  return redirect '/login/sign_in' unless session[:identity]
  @place = Place.find(params[:place_id])
  @average_rating = @place.reviews.average('rating')
  @average_rating = @average_rating.round 2 if @average_rating

  hh = { review_text: 'Enter text review',
         rating:      'Enter rating' }
  @error = hh.select { |key| params[key] == '' }.values.join(', ')
  return erb :place if @error != ''

  rating = params[:rating].to_i
  if rating < 1 || rating > 5
    @error = 'Enter rating 1-5'
    return erb :place
  end

  new_review = @place.reviews.new
  new_review.text = params[:review_text]
  new_review.rating = rating
  new_review.save

  redirect "/places/#{params[:place_id]}"
end
