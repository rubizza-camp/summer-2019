require_relative 'helpers/session_state'

module LogoutCommand
  include SessionState

  def logout!(*)
    return unless allready_registered
    return unless allready_checkouted

    good_bye
  end

  def good_bye
    redis = Redis.new
    redis.del(session[:number])
    session.delete(:number)
    respond_with :message, text: 'Счастливо! Можешь зарегистрироваться снова -> /start'
  end
end
