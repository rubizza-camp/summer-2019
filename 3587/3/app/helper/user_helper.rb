module UserHelper
  def account_exist?
    @user = User.find_by_email(params[:email])
    return true if @user && @user.password == params[:password]
    flash[:error] = 'Неверно введенные данные'
    redirect '/login'
  end
end
