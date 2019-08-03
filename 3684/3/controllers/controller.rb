require_relative 'application_controller'
require 'bcrypt'

class Controller < ApplicationController
  get '/' do
    @restaurants = Restaurant.all
    erb :index
  end

  get '/restaurant/:id' do
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(score: count_score(@comments))
    @comments = Comment.includes(:user).where(restaurant_id: @restaurant.id)
    erb :show
  end

  get '/login' do
    erb :login_page
  end

  get '/registration' do
    erb :registration_page
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  post '/register' do
    hash = { name: params['name'],
             email: params['email'].downcase,
             password: params['password'],
             password_confirmation: params['password_confirmation'] }
    new_user = User.new(hash)
    if new_user.valid?
      new_user.password = BCrypt::Password.create(params['password'])
      new_user.save(validate: false)
      session[:user_id] = User.last.id
      redirect '/'
    else
      flash[:message] = new_user.errors.messages.values.first[0]
      redirect '/registration'
    end
  end

  post '/log_in' do
    @user = User.find_by(email: params['email'].downcase)
    if @user && BCrypt::Password.new(@user[:password]) == params['password']
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:message] = 'Ошибка входа в аккаунт'
      redirect '/login'
    end
  end

  post '/leave_comment' do
    session.delete(:message)
    new_comment = Comment.new(params.merge!(session.to_hash.slice('user_id', 'restaurant_id')))
    if new_comment.valid?
      new_comment.save
      redirect "restaurant/#{params[:restaurant_id]}"
    else
      session[:message] = new_comment.errors.messages.values.first[0]
      partial(:comment_form)
    end
  end

  private

  def count_score(comm)
    comm.empty? ? 0 : comm.inject(0) { |total, temp| total + temp.score }.to_f / comm.size
  end
end
