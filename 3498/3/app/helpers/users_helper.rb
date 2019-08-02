module UsersHelper
  include BCrypt

  def register_user
    @user = User.new(name: params[:username], email: params[:email], password: params[:password])
    params[:password] ? @user.save : @error = 'Enter password!'
    session[:user_id] = @user.id.to_s
  end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      session[:user_id] = @user.id.to_s
    else
      @error = 'Wrong password'
    end
  end

  def login?
    session[:user_id]
  end
end
