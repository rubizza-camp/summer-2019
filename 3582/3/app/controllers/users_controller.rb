class UsersController < ApplicationController
  get '/login' do
    erb :'user/login'
  end

  post '/login' do
    if logged_in?
      flash[:message] = I18n.t(:already_logged_in)
      redirect '/'
    else
      @user = User.find_by(email: params[:email])
      if @user && BCrypt::Password.new(@user.password) == params[:password]
        session[:user_id] = @user.id
        flash[:message] = I18n.t(:success_login)
        redirect '/'
      else
        flash[:message] = I18n.t(:bad_credentials)
        redirect '/login'
      end
    end
  end

  get '/sign_up' do
    erb :'user/create_user'
  end

  post '/sign_up' do
    if logged_in?
      flash[:message] = I18n.t(:already_logged_in)
      redirect '/'
    else
      user = User.new(name: params[:name])
      user.email = params[:email]
      user.password = BCrypt::Password.create(params[:password])
      if user.valid?
        user.save
        flash[:message] = [I18n.t(:success_registration), params[:name]].join(' ')
        session[:user_id] = user.id
        redirect '/'
      else
        flash[:message] = user.errors.messages.values.join('<br>')
        redirect '/sign_up'
      end
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = I18n.t(:logged_out)
    redirect '/login'
  end
end
