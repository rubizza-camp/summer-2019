require 'rubygems'
require 'sinatra/base'
require 'warden'
require 'rack-flash'
require 'data_mapper'
require 'faker'
require 'bcrypt'
require 'require_all'
require 'pry'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:./db/rubizza_task3.db')
require_all './**/*.rb'
DataMapper.finalize.auto_upgrade!
helpers ApplicationHelpers

enable :sessions
set :session_secret, "in cause of that i've losted 2 hours, shotgun don't work without that secret"
use Rack::Flash

post '/auth/login' do
  env['warden'].authenticate!

  flash[:success] = 'Successfully logged in'

  if session[:return_to].nil?
    redirect '/'
  else
    redirect session[:return_to]
  end
end

post '/auth/unauthenticated' do
  session[:return_to] = env['warden.options'][:attempted_path]
  puts env['warden.options'][:attempted_path]
  flash[:error] = env['warden'].message || 'You must to login to continue'
  redirect '/auth/login'
end

get '/auth/logout' do
  env['warden'].raw_session.inspect
  env['warden'].logout
  flash[:success] = 'Successfully logged out'
  redirect '/'
end

get '/auth/login' do
  erb :'auth/login'
end

get '/' do
  @bars = Bar.all
  erb :'pages/index'
end

get '/bars/new' do
  env['warden'].authenticate!
  erb :'bars/new'
end

post '/bars/new' do
  params.delete 'submit'
  @bar = Bar.create(params)
  redirect '/'
end

get '/bars/:id/show' do
  @bar = Bar.get(params[:id])
  @bar_rate = calculate_rate(params[:id])
  @comments = Comment.all(bar_id: params[:id])
  erb :'bars/show'
end

get '/bars/:id/comments/new' do
  env['warden'].authenticate!
  @bar_id = params[:id]
  erb :'comments/new'
end

post '/bars/:bar_id/comments/new' do
  env['warden'].authenticate!
  params.delete 'submit'
  Comment.create(params)
  redirect "/bars/#{params[:bar_id]}/show"
end
