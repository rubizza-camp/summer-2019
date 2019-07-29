module UserHelper
  def current_user
    User.find_by(email: session[:email])
  end

  def login?
    session[:email] ? true : false
  end
end
