require './config/environment'
require 'byebug'
require 'bcrypt'
require 'sinatra'
require 'sinatra/session'
# :reek:all

def median(reviews)
  array = []
  reviews.each do |review|
    array.push(review.mark)
  end
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

def hash_password(password)
  BCrypt::Password.create(password).to_s
end

def validate_password(hash_password, _password)
  BCrypt::Password.new(hash_password) == params[:password]
end

class ApplicationController < Sinatra::Base
  register Sinatra::Session
  helpers Sinatra::Param

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  not_found do
    content_type 'text/html'
    status 404
    erb :error
  end

  get '/' do
    @restraunts = Restraunt.all
    erb :index
  end

  get '/login' do
    if session?
      redirect '/'
    else
      erb :login, layout: :login_layout
    end
  end

  get '/logout' do
    session_end!
    redirect '/'
  end

  post '/sign_in' do
    user = User.all.find_by(email: params[:email])
    if user && validate_password(user.password, params[:password])
      session_start!
      session[:name] = user.name
      session[:user_id] = user.id
      redirect '/'
    else
      erb :login
    end
  end

  get '/register' do
    erb :register, layout: :login_layout
  end

  post '/create_user' do
    param :email, String, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    user_id = User.all.last.id + 1
    User.create!(
      id: user_id,
      name: params[:name],
      email: params[:email],
      password: hash_password(params[:password])
    )
    redirect '/'
  end

  get '/restraunts/:id' do
    @restraunt = Restraunt.all.find_by(id: params[:id])
    erb :restraunt
  end

  post '/new_review/:id' do
    restraunt = Restraunt.all.find_by(id: params[:id])
    review_id = Review.all.last.id + 1 if restraunt.reviews.any?
    param :body, String, min_length: 50
    restraunt.reviews.create!(
      id: review_id,
      body: params[:body],
      mark: params[:mark],
      user_id: session[:user_id]
    )
    restraunt.update(avg_mark: median(restraunt.reviews))
    redirect '/restraunts/' + params[:id]
  end
end
