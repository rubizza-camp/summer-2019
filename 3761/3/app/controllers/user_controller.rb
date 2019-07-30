class UserController < ApplicationController
  get '/sign_in' do
    return redirect '/' if session?

    erb :sign_in
  end

  get '/sign_up' do
    return redirect '/' if session?

    erb :sign_up
  end

  get '/logout' do
    session_end!
    redirect '/'
  end

  post '/sign_in' do
    session_start if account_exist?
  end

  post '/sign_up' do
    @user = User.new(name: params['name'], email: params['email'], password: params[:password])
    if @user.valid?
      @user.save
      session_start
    else
      flash[:error] = error_message
      redirect '/sign_up'
    end
  end
end
