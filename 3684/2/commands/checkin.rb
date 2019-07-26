module Checkin
  def checkin!
    if redis.get('telegram_id').include?(from['id'].to_s)
      if session[:checkin]
        respond_with :message, text: I18n.t(:without_checkout)
        return
      end
      update_session_info_checkin
    else
      respond_with :message, text: I18n.t(:without_registration)
    end
  end

  def update_session_info_checkin
    session[:checkin] = true
    session[:timestamp] = Time.now
    session[:operation] = 'checkin'
    save_context :photo
    respond_with :message, text: I18n.t(:face_control)
  end
end
