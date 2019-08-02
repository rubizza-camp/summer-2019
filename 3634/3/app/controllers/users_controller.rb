class UsersController < ApplicationController
  before '/(login|register)' do
    if current_user
      flash[:message] = 'Already logged in'
      redirect to '/'
    end
  end

  get '/login' do
    slim :'users/login.html', layout: :'layouts/application.html'
  end

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

  get '/register' do
    slim :'users/register.html', layout: :'layouts/application.html'
  end

  post '/register' do
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = 'Yay! Registration is successful!'
      redirect '/'
    else
      flash[:message] = 'Please, fill in the fields correctly'
    end
  end

  delete '/logout' do
    session.clear
    flash[:message] = 'You have been logged out'
    redirect '/'
  end
end
