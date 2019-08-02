module UserHelper
  def account_exists?
    if find_in_db && right_password?
      true
    else
      flash[:error] = I18n.t(:incorrect_password_or_email)
      false
    end
  end

  def logout
    session[:user_id] = nil
  end

  def login
    logout if login?
    session['user_id'] = @user.id if account_exists?
    redirect '/'
  end

  def find_in_db
    @user = User.find_by(email: params[:email])
  end

  def error_message
    @user.errors.details.dig(:email, 0, :error)
  end

  def right_password?
    @user.password == params[:password]
  end

  def password?
    if params[:password] == params[:confirm_password]
      @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    else
      false
    end
  end

  def stars
    @stars = @shop.reviews.average(:grade).round(2)
  end

  def login?
    session[:user_id]
  end
end
