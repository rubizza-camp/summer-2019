require 'bcrypt'
module UserHelper
  def login
    @user = User.find_by(email: params['email'].downcase)
    if @user && BCrypt::Password.new(@user[:password]) == params['password']
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:message] = 'Неправильный email или пароль'
      redirect back
    end
  end
end
