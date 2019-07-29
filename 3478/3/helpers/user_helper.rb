# frozen_string_literal: true

module UserHelper
  def add_user
    @user[:password] = Digest::SHA1.hexdigest(params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect '/'
  end

  def valid_user_registration?
    return true if Truemail.valid?(params['email']) && !User.find_by(email: params[:email])

    flash[:danger] = 'Account with this email is already registered'
    redirect '/sign_up'
  end

  def valid_user_login?
    return true if @user && (@user.password == Digest::SHA1.hexdigest(params[:password]))

    flash[:danger] = 'No such user!'
    redirect '/sign_in'
  end

  def sign_in_user
    session[:user_id] = @user.id
    redirect '/'
  end

  def valid_log_state
    return true unless session[:user_id]

    flash[:danger] = 'You are logged already'
    redirect '/'
  end
end
