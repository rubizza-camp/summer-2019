# frozen_string_literal: true

require 'sinatra'
require 'rubygems'
require 'sinatra/activerecord'
require 'erb'
require 'sinatra/flash'
require 'bcrypt'
require 'email_address'
require 'dotenv'
Dir['./app/models/*.rb'].each { |file| require file }
Dir['./app/helpers/*.rb'].each { |file| require file }
Dotenv.load
class Controller < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  include UserHelper
  include CommentHelper
  include MessagesHelper
  include RestaurantHelper

  configure do
    enable :sessions
    set :session_secret, ENV['key']
  end

  get '/' do
    @restaurants = Restaurant.all
    erb :home_page
  end

  get '/sign_up' do
    erb :sign_up
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/login' do
    login
    redirect '/'
  end

  get '/logout' do
    logout
    redirect '/'
  end

  post '/rate' do
    comment_to_the_cafe
    redirect "/#{session[:cafe_name]}"
  end

  post '/registration' do
    sign_up
    redirect '/'
  end

  get '/:name' do
    info_about_selected_cafe
    erb :page_about_restaurant
  end
end
