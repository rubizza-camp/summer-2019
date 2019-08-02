module SessionHelper
  def valid_password?
    return true unless params[:password].empty?
    flash[:error] = 'Введите пароль'
  end

  def valid_email?
    return true if Truemail.valid?(params[:email])
    flash[:error] = 'Неправильная почта'
    redirect '/register'
  end

  def account_exist?
    @user = User.find_by_email(params[:email])
    return true if @user && @user.password == params[:password]
    flash[:error] = 'Неверно введенные данные'
  end
end
