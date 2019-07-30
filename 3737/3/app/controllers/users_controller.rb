class UsersController < ApplicationController
  get '/signup' do
    unless logged_in
      erb :registration
    else
      @user = current_user
      redirect '/'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email],
                     password_hash: params[:password])
    puts @user.username, @user.email, @user.password_hash
    if @user.save
      session[:user_id] = @user.id
      puts session
      puts session[:user_id]
      redirect '/'
    else
      puts @user.username, @user.email
      erb :registration
    end
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user
      session[:user_id] = @user.id
      redirect '/'
    else
      erb :login
    end
  end

  get '/login' do
    unless current_user
      erb :login
    else
      redirect '/'
    end
  end

  get '/logout' do
    if logged_in
      session.destroy
      redirect '/'
    end
  end
end
