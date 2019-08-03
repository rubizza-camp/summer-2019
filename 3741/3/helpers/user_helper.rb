# frozen_string_literal: true

module UserHelper
  def sign_up_redirect
    if register_data_valid?
      @user.save
      show_message 'user create, login in please'
      redirect '/'
    else
      show_message 'bad email or login already exist'
      redirect '/session/signup'
    end
  end

  def sign_in_redirect
    find_user_by_mail
    if user_data_valid?
      session[:user_id] = @user.id
      redirect '/'
    else
      show_message 'wrong email'
      redirect '/session/login'
    end
  end

  def register_data_valid?
    create_user
    @user.valid? && Truemail.valid?(params['email'])
  end

  def user_data_valid?
    @user && @user.password == params[:password]
  end

  def find_user_by_mail
    @user = User.find_by(email: params[:email])
  end

  def create_user
    @user = User.new(params.slice('username', 'email', 'password'))
  end
end
