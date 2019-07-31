require './config/environment'
require './app/helpers/review_helper.rb'
require './app/services/create_account.rb'
require './app/services/create_review.rb'
require './app/services/login.rb'
require 'byebug'
require 'bcrypt'
require 'sinatra'
require 'sinatra/session'
# :reek:all
# rubocop: disable all

class ApplicationController < Sinatra::Base
  register Sinatra::Session
  helpers Sinatra::Param, ReviewHelper

  EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

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

  post '/login' do
    subscribe = Login.new.call(session, params)
    if subscribe[:success]
      session_start!
      session[:name] = subscribe[:payload].name
      session[:account_id] = subscribe[:payload].id
      redirect '/'
    else
      erb :login
    end
  end

  get '/logout' do
    session_end!
    redirect '/'
  end

  get '/account/new' do
    erb :account, layout: :login_layout
  end

  post '/account' do
    param :email, String, format: EMAIL_REGEX
    CreateAccount.new.call(params)
    redirect '/'
  end

  get '/restraunts/:id' do
    @restraunt = Restraunt.find(params[:id])
    erb :restraunt
  end

  post '/restraunts/:id/review' do
    param :body, String, min_length: 50
    CreateReview.new.call(params, session)
    redirect '/restraunts/' + params[:id]
  end
end
