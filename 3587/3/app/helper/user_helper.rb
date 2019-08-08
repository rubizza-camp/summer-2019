module UserHelper
  def login
    session['user_id'] = @user.id if find_in_db && right_password?
    redirect '/'
  end

  def find_in_db
    @user = User.find_by(email: params[:email])
  end

  def right_password?
    @user.password == params[:password]
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
end
