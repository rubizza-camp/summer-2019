require 'sinatra/base'

module UserHelper
  def account_exist?
    @user = User.find_by(email: params['email'])
    return true if @user && @user.password == params[:password]

    flash[:error] = I18n.t(:incorrect_password)
    redirect '/sign_in'
  end

  def error_message
    nickname_error_message + email_error_message
  end

  private

  def nickname_error_message
    case @user.errors.details.dig(:name, 0, :error)
    when :blank
      I18n.t(:blank_nickname)
    when :taken
      I18n.t(:existing_nickname)
    else
      @user.errors.details.dig(:name, 0, :error).to_s
    end
  end

  def email_error_message
    case @user.errors.details.dig(:email, 0, :error)
    when :blank
      I18n.t(:blank_email)
    when :taken
      I18n.t(:existing_email)
    else
      @user.errors.details.dig(:email, 0, :error).to_s
    end
  end
end
