require_relative '../../lib/user_methods'

module CheckinCommand
  def checkin!(*)
    if UserMethods.registered?(from['id'])
      respond_with :message, text: 'Пришли фото!'
      session['status'] = 'checkins'
      save_context :selfie
    else
      respond_with :message, text: 'Сначала нужно зарегистрироваться командой /start'
    end
  end
end
