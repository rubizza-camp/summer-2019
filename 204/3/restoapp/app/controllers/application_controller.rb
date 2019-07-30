require './config/environment'
require './app/helpers/review_helper.rb'
require './app/services/account_creator.rb'
require './app/services/review_creator.rb'
require './app/services/sign_in.rb'
require 'byebug'
require 'bcrypt'
require 'sinatra'
require 'sinatra/session'
# :reek:all

EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/.freeze

class ApplicationController < Sinatra::Base
  register Sinatra::Session
  helpers Sinatra::Param, ReviewHelper

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
    subscribe = SignIn.new.call(session, params)
    if subscribe[:success] == true
      session_start!
      session[:name] = subscribe[:payload].name
      session[:account_id] = subscribe[:payload].id
      redirect '/'
    else
      erb :login
    end
  end

  get '/register' do
    erb :register, layout: :login_layout
  end

  post '/create_account' do
    param :email, String, format: EMAIL_REGEX
    AccountCreator.new(params).call
    redirect '/'
  end

  get '/restraunts/:id' do
    @restraunt = Restraunt.find(params[:id])
    erb :restraunt
  end

  post '/new_review/:id' do
    param :body, String, min_length: 50
    restraunt = Restraunt.find(params[:id])
    ReviewCreator.new.call(params, session, restraunt)
    redirect '/restraunts/' + params[:id]
  end
end
