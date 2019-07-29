require_relative 'application_controller'
require 'bcrypt'

class Controller < ApplicationController
  get '/restaurant/:id' do
    update_score(params[:id])
    @restaurant = Restaurant.find(params[:id])
    @comments = @restaurant.comments
    erb :show
  end

  post '/registrate' do
    password = BCrypt::Password.create(params['password'])
    hash = { name: params['name'], email: params['email'], password: password }
    User.create(hash)
    session[:user_id] = User.last.id
    redirect '/restaurants'
  end

  post '/log_in' do
    @user = User.find_by(email: params['email'])
    if BCrypt::Password.new(@user[:password]) == params['password']
      session[:user_id] = @user.id
      redirect '/restaurants'
    else
      redirect '/fail'
    end
  end

  post '/leave_comment' do
    hash = {
      text: params['text'],
      score: params['score'],
      user_id: session[:user_id],
      restaurant_id: session['rest_id']
    }
    Comment.create(hash)
    redirect "/#{@env['HTTP_REFERER'].slice(22..@env['HTTP_REFERER'].length)}"
  end

  get '/dislogin' do
    session[:user_id] = false
    redirect '/restaurants'
  end

  get '/restaurants' do
    @restaurants = Restaurant.all
    erb :index
  end

  get '/login' do
    erb :login_page
  end

  get '/registration' do
    erb :registration_page
  end

  get '/fail' do
    'SUCK DICK'
  end

  private

  def update_score(id)
    Restaurant.find(id).update(score: count_score(Restaurant.find(id).comments))
  end

  def count_score(comments)
    amount = 0.0
    comments.each { |com| amount += com.score }
    amount / comments.size
  end
end
