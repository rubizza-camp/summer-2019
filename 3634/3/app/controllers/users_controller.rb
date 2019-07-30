class UsersController < ApplicationController
  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = 'Yay! Login is successful!'
      redirect '/'
    else
      flash[:message] = "We can't find you, Please try again"
    end
  end

  post '/register' do
    if params[:name].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Please don't leave blank content"
    else
      @user = User.create(
        name: params[:name],
        email: params[:email],
        password: params[:password]
      )
      session[:user_id] = @user.id
      flash[:message] = 'Yay! Registration is successful!'
      redirect '/'
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = 'You have been logged out'
    redirect '/'
  end
end
