module UserHelper
  include BCrypt

  def create_user
    @user = User.new(name: params[:username], email: params[:email], password: params[:password])
    @user.save!
  end

  def sign_up
    check_info_for_sign_up
    create_user
    session[:user_id] = @user.id
  end

  def check_info_for_sign_up
    show_message_about_problems unless !find_user_in_db || valid_email? || password?
  end

  def logout
    session[:user_id] = nil
  end

  def login
    logout if login?
    show_message_about_problems unless find_user_in_db || right_password?
    session[:user_id] = @user.id
  end

  def password?
    params[:password] == params[:confirm_password]
  end

  def find_user_in_db
    @user = User.find_by(email: params[:email])
  end

  def right_password?
    Password.new(@user.password_hash) == params[:password]
  end

  def valid_email?
    EmailAddress.valid?(params[:email])
  end

  def login?
    session[:user_id]
  end
end
