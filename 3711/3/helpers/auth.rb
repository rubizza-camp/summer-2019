require_relative 'crypt'

module AuthHelper
  def loged_in?
    session.key?(:user_id) && session[:user_id]
  end

  def currect_user_id
    session[:user_id]
  end

  def user_exists?
    @user && @user.pass_hash == md5_encrypt(params[:password])
  end
end
