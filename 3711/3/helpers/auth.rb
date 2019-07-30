require_relative 'crypt'

module AuthHelper
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  def loged_in?
    session.key?(:user)
  end

  def correct_login?
    @user && @user.pass_hash == md5_encrypt(params[:password])
  end

  def signup_mail_check(mail)
    return invalid_mail unless mail.match?(VALID_EMAIL_REGEX)
    return already_exists if User.find_by(mail: mail)
  end

  def invalid_mail
    retry_action 'Sign up failed: invalid e-mail.', '/signup'
  end

  def already_exists
    retry_action 'Sign up failed: user with such e-mail already exists.', '/signup'
  end

  def retry_login
    retry_action 'Login failed: wrong e-mail or password.', '/login'
  end

  def retry_signup
    retry_action 'Sign up failed: user with such e-mail already exists.', '/signup'
  end

  def retry_action(text, redirect_path)
    session[:error] = text
    redirect redirect_path
  end

  def currect_user
    session[:user]
  end

  def authorization
    session[:user] = @user
    redirect '/'
  end

  def logoff
    session.delete(:user)
    redirect back
  end
end
