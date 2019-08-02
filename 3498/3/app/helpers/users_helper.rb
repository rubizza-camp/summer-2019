module UsersHelper
  include BCrypt

  def register_user
    @user = User.new(name: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id.to_s
    else
      session[:error] = 'Registration failed!'
    end
  end

  def login_user
    @user = User.find_by(email: params[:email])
    @user ? validate_password : session[:error] = 'You need to sign up'
  end

  def validate_password
    if @user.password == params[:password]
      session[:user_id] = @user.id.to_s
    else
      session[:error] = 'Wrong password'
    end
  end

  def login?
    session[:user_id]
  end
end
