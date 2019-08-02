require_relative 'application_controller'
require 'bcrypt'

class Controller < ApplicationController
  get '/home' do
    erb :home
  end

  get '/' do
    @restaurants = Restaurant.all
    erb :restaurants
  end

  get '/registration' do
    erb :registration_page
  end

  post '/registrate' do
    hash = { name: params['name'],
             email: params['email'].downcase,
             password: params['password'] }
    new_user = User.new(hash)
    if new_user.valid?
      new_user.password = BCrypt::Password.create(params['password'])
      new_user.save(validate: false)
      session[:user_id] = User.last.id
      redirect '/home'
    else
      flash[:message] = new_user.errors.messages.values.first[0]
      redirect '/registration'
    end
  end

  post '/log_in' do
    @user = User.find_by(email: params['email'].downcase)
    if @user && BCrypt::Password.new(@user[:password]) == params['password']
      session[:user_id] = @user.id
      redirect back
    else
      flash[:message] = 'Неправильный email или пароль'
      redirect '/home'
    end
  end

  post '/logout' do
    session[:user_id] = false
    redirect back
  end

  get '/restaurant/:id' do
    @restaurant = Restaurant.find(params[:id])
    @comments = Comment.includes(:user).where(restaurant_id: @restaurant.id)
    @restaurant.update(score: count_score(@comments))
    erb :restaurant_page
  end

  post '/leave_comment' do
    hash = { text: params['text'],
             score: params['score'],
             user_id: session[:user_id],
             restaurant_id: session['rest_id'] }
    new_comment = Comment.new(hash)
    if new_comment.valid?
      new_comment.save
    else
      flash[:message] = new_comment.errors.messages.values.first[0]
    end
    redirect back
  end

  private

  def count_score(comm)
    comm.empty? ? 0 : comm.inject(0) { |total, temp| total + temp.score }.to_f / comm.size
  end
end
