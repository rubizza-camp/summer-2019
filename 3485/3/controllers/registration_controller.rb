class RegistrationController < ApplicationController
  get '/registration' do
    erb :registration
  end

  post '/registration' do
    hash = { name: params['name'],
             email: params['email'].downcase,
             password: params['password'],
             password_confirmation: params['password_confirmation'] }
    user = User.new(hash)
    if user.valid?
      user.password = BCrypt::Password.create(params['password'])
      user.save(validate: false)
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:message] = user.errors.messages.values.first[0]
      redirect '/registration'
    end
  end
end
