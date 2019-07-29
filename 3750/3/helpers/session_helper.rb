require 'sinatra/base'

module SessionHelper
  def login
    session[:user_id] = @user.id
    session[:user_name] = @user.login
  end

  def encrypt_password(password)
    BCrypt::Password.create(password)
  end

  def decrypt_password
    BCrypt::Password.new(@user.password_hash)
  end

  def user_exists?
    @user && (decrypt_password == params[:password])
  end

  def email_valid?
    Truemail.valid?(params['email'])
  end
end
