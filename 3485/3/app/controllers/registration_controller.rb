class RegistrationController < ApplicationController
  before '/registration' do
    redirect '/' if current_user
  end

  get '/registration' do
    erb :registration
  end

  post '/registration' do
    result = UserSaver.call(name: params['name'],
                            email: params['email'],
                            password: params['password'],
                            password_confirmation: params['password_confirmation'])
    user = result[:value]
    success = result[:success]

    if success
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:message] = user.errors.messages.values.first[0]
      redirect back
    end
  end
end
