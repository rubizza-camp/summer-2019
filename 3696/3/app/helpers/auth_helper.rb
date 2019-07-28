require 'sinatra/base'

module AuthHelper
  def user_exists?
    @user && (password == params[:password])
  end

  def password
    BCrypt::Password.new(@user.password_hash)
  end

  def user_logged?
    session[:user_id]
  end

  def can_register?
    @user.valid? && Truemail.valid?(params['email'])
  end

  def log_in
    session[:user_id] = @user.id
  end

  def avoid_repeated_login
    return unless user_logged?

    warning_message 'You are logged already'
    redirect '/'
  end

  def avoid_repeated_logout
    return if user_logged?

    warning_message 'You are logged out already'
    redirect '/'
  end

  def successful_login
    log_in
    info_message 'Success!'
    redirect '/'
  end
end
