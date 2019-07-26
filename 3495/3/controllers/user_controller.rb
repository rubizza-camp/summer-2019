class UserController < ApplicationController
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    @restaurants = Restaurant.all
    erb :main
  end

  post '/user_login' do
    user = User.where(['email = ?', params['email']]).first
    if user && BCrypt::Password.new(user[:password]) == params['pass']
      session[:name] = user[:name].to_s && session[:id] = user[:id]
    else
      set :sessions, :message => 'Trouble with password or email'
    end
    redirect "#{@env["HTTP_REFERER"]}"
  end
  
  post '/user_logout' do
    session.delete(:name) && session.delete(:id)
    redirect "#{@env["HTTP_REFERER"]}"
  end

  post '/user_registration' do
    User.create(name: params['name'], email: params['email'], password: BCrypt::Password.create(params['pass']).to_s)
    redirect "#{@env["HTTP_REFERER"]}"
  end

  get '/restaurant_registration' do
    erb :restaurant_registration
  end

  get '/restaurant_registrate' do
    binding.pry
    Restaurant.create(name: params['nam'], short_description: params['short_desc'], long_description: params['long_desc'], address: params['addr'])
    erb :main
  end

  get '/restaurant/:id' do
    @reviews = Review.where(["restaurant_id = ?", params['id']])
    @restaurant = Restaurant.find(params['id'])
    @user_names = []
    @user_ids = @reviews.pluck(:user_id)
    @users_names = User.where(id: @user_ids).pluck(:name)
    erb :show_restaurant
  end

  post '/restaurant/:id' do
    @restaurant = Restaurant.find(params['id'])
    Review.create(title: params['title'], short_description: params['short_description'], restaurant_id: params['id'], user_id: session[:user_id])
    @reviews = Review.where(["restaurant_id = ?", params['id']])
    redirect "/restaurant/#{params['id']}"
  end
end