module DataCheckConversation
  def photo_check(*)
    if photo?
      photo_save
      save_context :geo_check
      respond_with :message, text: 'Good. Now i need your geolocation'
    else
      save_context :photo_check
      reply_with :message, text: "I don't see a photo here"
    end
  end

  def geo_check(*)
    if !geo?
      save_context :geo_check
      respond_with :message, text: "I don't see you in place"
    else
      geo_save
      session_ending
    end
  end

  private

  def session_ending
    checkin_session_ending if session[:command] == 'checkin'
    checkout_session_ending if session[:command] == 'checkout'
  end

  def checkin_session_ending
    respond_with :message, text: 'Your shift have successfully begun'
    set_checkin_flags
  end

  def checkout_session_ending
    respond_with :message, text: 'I hope you worked well today'
    respond_with :message, text: 'Have a nice day'
    respond_with :sticker, sticker: 'CAADAgADJgADwnaQBi5vOvKDgdd8Ag'
    set_checkout_flags
  end

  def set_checkin_flags
    session[:checkin?] = true
    session[:checkout?] = false
  end

  def set_checkout_flags
    session[:command] = nil
    session[:checkin?] = false
    session[:checkout?] = true
  end
end
