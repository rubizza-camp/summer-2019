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
    @user = User.create(name: params['name'], email: params['email'], password: params[:password])
    if can_registered?
      @user.save
      session_start
    end
  end
end
