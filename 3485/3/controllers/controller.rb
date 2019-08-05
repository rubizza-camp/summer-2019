require_relative 'application_controller'
require 'bcrypt'

class Controller < ApplicationController
  get '/login' do
    erb :login
  end

  get '/' do
    @restaurants = Restaurant.all
    erb :index
  end

  post '/login' do
    @user = User.find_by(email: params['email'].downcase)
    if @user && BCrypt::Password.new(@user[:password]) == params['password']
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:message] = 'Неправильный email или пароль'
      redirect back
    end
  end

  post '/logout' do
    session[:user_id] = false
    redirect back
  end

  get '/restaurants/:id' do
    @restaurant = Restaurant.find(params[:id])
    @comments = @restaurant.comments.includes(:user)
    @restaurant.update(score: @comments.average(:score))
    erb :restaurant_page
  end

  post '/leave_comment' do
    hash = { text: params['text'],
             score: params['score'],
             user_id: session[:user_id],
             restaurant_id: session['rest_id'] }
    comment = Comment.new(hash)
    if comment.save
    else
      flash[:message] = comment.errors.messages.values.first[0]
    end
    redirect back
  end
end
