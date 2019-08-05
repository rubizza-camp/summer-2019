# frozen_string_literal: true

# rubocop:disable Metrics/LineLength

module UserHelper
  def add_user
    @current_user[:password] = Digest::SHA1.hexdigest(params[:password])
    @current_user.save
    sign_in_user
  end

  def valid_password?
    return true if params['password'] == params['password_confirmation']

    flash[:danger] = 'Passwords do not match'
    redirect '/sign_up'
  end

  def unregistered_email?
    return true unless User.find_by(email: params[:email])

    flash[:danger] = 'Account with this email is already registered'
    redirect '/sign_up'
  end

  def valid_user_login?
    return true if @current_user && (@current_user.password == Digest::SHA1.hexdigest(params[:password]))

    flash[:danger] = 'No such user!'
    redirect '/sign_in'
  end

  def logged_in?
    return true if session[:user_id]

    flash[:danger] = 'You must be logged in!'
    false
  end

  def sign_in_user
    session[:user_id] = @current_user.id
    redirect '/'
  end
end
# rubocop:enable Metrics/LineLength
