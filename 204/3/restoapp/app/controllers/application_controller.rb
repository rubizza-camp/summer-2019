require './config/environment'
require 'byebug'
require 'bcrypt'
require 'sinatra'
require 'sinatra/session'

def hash_password(password)
  BCrypt::Password.create(password).to_s
end

def validate_password(hash_password, _password)
  BCrypt::Password.new(hash_password) == params[:password]
end

class ApplicationController < Sinatra::Base
  register Sinatra::Session

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
      erb :login, layout: false
    end
  end

  get '/logout' do
    session_end!(destroy = true)
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
      erb :sign_in
    end
  end

  get '/register' do
    erb :register, layout: false
  end

  post '/create_user' do
    users = User.all
    user_id = users.last.id + 1
    User.create!(
      id: user_id,
      name: params[:name],
      email: params[:email],
      password: hash_password(params[:password])
    )

    redirect '/'
  end

  get '/restraunts/:id' do
    @restraunts = Restraunt.all do |restraunt|
      restraunt.id == params[:id]
    end
    @restraunt = Restraunt.find_by(id: params[:id])
    @restraunt_reviews = Review.all.where(restraunt_id: params[:id])
    avg_mark = Review.all.where(restraunt_id: params[:id]).ids.reduce(:+)
    @restraunt.update(avg_mark: avg_mark)
    @location = { langitude: @restraunt.location.split(',')[0],
                  longitude: @restraunt.location.split(',')[1].delete(' ') }
    erb :restraunt
  end

  post '/new_review/:id' do
    reviews = Review.all
    review_id = reviews.last.id + 1 if reviews.present?
    Review.create!(
      id: review_id,
      body: params[:body],
      mark: params[:mark],
      user_id: session[:user_id],
      restraunt_id: params[:id].to_i
    )
    redirect '/restraunts/' + params[:id]
  end
end
