require './config/environment'
require './app/helpers/application_helpers'
require './app/services/warden'
require './app/services/rate_calculator'
require './app/services/email_shower'
require './app/services/review_creator'
require 'rack-flash'
require 'warden'
require 'will_paginate'
require 'will_paginate/active_record'
class ApplicationController < Sinatra::Base
  include ApplicationHelpers
  include RateCalculator
  register EmailShower
  register WillPaginate::Sinatra

  ERROR_LOGIN_MESSAGE = 'You must to login to continue'.freeze

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions
  set :session_secret, 'rubizza awesome'
  use Rack::Flash

  get '/' do
    @bars = Bar.paginate(page: params[:page])
    erb :'pages/index'
  end

  post '/auth/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path]
    flash[:error] = env['warden'].message || ERROR_LOGIN_MESSAGE
    redirect '/auth/login'
  end
end
