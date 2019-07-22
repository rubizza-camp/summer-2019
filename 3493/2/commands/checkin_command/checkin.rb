require_relative '../../support_methods/user_methods/user_methods.rb'

module CheckinCommand
  def checkin!(*)
    if UserMethods.registered?(from['id'])
      respond_with :message, text: 'Фоточку в студию'
      session['status'] = 'checkins'
      save_context :selfi
    else
      respond_with :message, text: 'Сначала нужно зарегистрироваться командой /start'
    end
  end
end
