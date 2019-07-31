class UserController < ApplicationController
  get '/login' do
    erb :'user/login', layout: false
  end

  post '/login' do
    if logged_in?
      flash[:message] = 'You were already logged in'
      redirect '/'
    else
      @user = User.find_by(email: params[:email])
      if @user && BCrypt::Password.new(@user.password) == params[:password]
        session[:user_id] = @user.id
        flash[:message] = 'Successfully logged in'
        redirect '/'
      else
        flash[:message] = 'Your email or password were not correct. Please try again.'
        redirect '/login'
      end
    end
  end

  get '/signup' do
    erb :'user/create_user', layout: false
  end

  post '/signup' do
    if logged_in?
      flash[:message] = 'You were already logged in'
      redirect '/'
    else
      user = User.new(name: params[:name])
      user.email = params[:email]
      user.password = BCrypt::Password.create(params[:password])
      if user.valid?
        user.save
        flash[:message] = "Congratulations, you succesfully registered #{params[:name]}"
        session[:user_id] = user.id
        redirect '/'
      else
        flash[:message] = user.errors.messages.values.join('<br>')
        redirect '/signup'
      end
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = 'You have been logged out of your account.'
    redirect '/login'
  end
end
