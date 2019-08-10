# frozen_string_literal: true

require 'digest'

class UserController < AppController
  include UserHelper

  get '/sign_up' do
    erb :sign_up
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/sign_up' do
    @user = User.create(name: name, email: email, password: encrypted_password)
    if @user.valid?
      sign_in_user
    else
      flash[:danger] = @user.errors.messages.values.join(' ')
    end
  end

  post '/sign_in' do
    valid_log_state
    @user = User.find_by(email: params[:email])
    sign_in_user if valid_user_login?
  end

  get '/logout' do
    session[:user_id] = nil
    redirect '/'
  end

  private

  def encrypted_password
    Digest::SHA1.hexdigest(params[:password])
  end
end
