module Checkin
  def checkin!(*)
    if redis.get('telegram_id').include?(from['id'].to_s)
      if session[:checkin]
        respond_with :message, text: 'Нужно зачекаутиться -> /checkout'
        return
      end
      update_session_info_checkin
      respond_with :message, text: 'Фейсконтроль'
    else
      respond_with :message, text: 'Пройдите регистрацию -> /start'
    end
  end

  def update_session_info_checkin
    session[:checkin] = true
    session[:timestamp] = Time.now
    session[:operation] = 'checkin'
    save_context :photo
  end
end
