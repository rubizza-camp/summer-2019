require_relative 'crypt'

module AuthHelper
  def loged_in?
    session.key?(:user) && session[:user]
  end

  def currect_user
    session[:user]
  end

  def user_exists?
    @user && @user.pass_hash == md5_encrypt(params[:password])
  end
end
