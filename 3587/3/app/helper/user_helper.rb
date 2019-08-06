module UserHelper
  def logout
    session[:user_id] = nil
  end

  def login
    logout if login?
    session['user_id'] = @user.id if find_in_db && right_password?
    redirect '/'
  end

  def find_in_db
    @user = User.find_by(email: params[:email])
  end

  def right_password?
    @user.password == params[:password]
  end

  def stars
    @stars = @shop.reviews.average(:grade).round(2)
  end

  def login?
    session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
