module Verifier
  def photo_check(*)
    if !payload['photo'].nil?
      photo_save
      save_context :geo_check
      reply_with :message, text: 'You looking pretty good'
      respond_with :message, text: 'Now i need your geolocation'
    else
      save_context :photo_check
      reply_with :message, text: "I don't see a photo here"
      respond_with :message, text: 'Send me something more photogenic'
    end
  end

  def geo_check(*)
    if !payload['location'].nil?
      geo_save
      reply_with :message, text: 'I see you'
      checkin_session_ending if session[:command] == 'checkin'
      checkout_session_ending if session[:command] == 'checkout'
    else
      save_context :geo_check
      reply_with :message, text: 'That is not location at all'
      respond_with :message, text: 'Show me yourself on map'
    end
  end

  def checkin_session_ending
    respond_with :message, text: 'Your shift have successfully begun :DDD:'
  end

  def checkout_session_ending
    respond_with :message, text: 'I hope today you got some things working'
    respond_with :message, text: 'Have a nice day'
    respond_with :sticker, sticker: 'CAADAgADJgADwnaQBi5vOvKDgdd8Ag'
    session[:command] = nil
    session[:checkin?] = false
  end
end