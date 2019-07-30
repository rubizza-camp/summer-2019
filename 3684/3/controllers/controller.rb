require_relative 'application_controller'
require 'bcrypt'
PREV_ROUT_FIRST_SYMBOL = 22

class Controller < ApplicationController
  get '/restaurant/:id' do
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(score: count_score(Restaurant.find(params[:id]).comments))
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
    if @user
      if BCrypt::Password.new(@user[:password]) == params['password']
        session[:user_id] = @user.id
        session[:fail] = false
        redirect '/restaurants'
      else
        login_fail_redirect
      end
    else
      login_fail_redirect
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
    redirect "/#{@env['HTTP_REFERER'].slice(PREV_ROUT_FIRST_SYMBOL..@env['HTTP_REFERER'].length)}"
  end

  get '/logout' do
    session[:user_id] = false
    redirect '/restaurants'
  end

  get '/restaurants' do
    @restaurants = Restaurant.all
    erb :index
  end

  get '/login_page' do
    erb :login_page
  end

  get '/registration' do
    erb :registration_page
  end

  private

  def login_fail_redirect
    session[:fail] = true
    redirect '/login_page'
  end

  def count_score(comments)
    comments.inject(0) { |total, temp| total + temp.score }.to_f / comments.size
  end
end
