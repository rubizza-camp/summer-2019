require 'sinatra/base'

module UserHelper
  def can_registered?
    true if user_valid? && email_valid?
  end

  def account_exist?
    @user = User.find_by(email: params['email'])
    return true if @user && @user.password == params[:password]

    flash[:error] = I18n.t(:incorrect_password)
    redirect '/sign_in'
  end

  private

  def user_valid?
    return true if @user.valid?

    flash[:error] = I18n.t(:account_already_exist)
    redirect '/sign_up'
  end

  def email_valid?
    return true if Truemail.valid?(params['email'])

    flash[:error] = I18n.t(:invalid_email)
    redirect '/sign_up'
  end
end
