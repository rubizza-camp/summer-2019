require './config/environment'
require './app/helpers/application_helpers'
require './app/services/warden'
require 'rack-flash'
require 'warden'
require 'will_paginate'
require 'will_paginate/active_record'
class ApplicationController < Sinatra::Base
  include ApplicationHelpers
  register WillPaginate::Sinatra

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
    flash[:error] = env['warden'].message || 'You must to login to continue'
    redirect '/auth/login'
  end
end
