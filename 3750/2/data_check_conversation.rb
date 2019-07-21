module DataCheckConversation
  WORKING_LOCATION = [53.915158, 27.569110].freeze
  MAX_DISTANCE_ALLOWED = 0.3

  def photo_check(*)
    if !payload['photo'].nil?
      photo_save
      save_context :geo_check
      respond_with :message, text: 'Good. Now i need your geolocation'
    else
      save_context :photo_check
      reply_with :message, text: "I don't see a photo here"
      respond_with :message, text: 'Send me something more photogenic'
    end
  end

  def geo_check(*)
    if payload['location'].nil?
      save_context :geo_check
      reply_with :message, text: 'That is not location at all. Show me yourself on the map'
    elsif !geo?
      save_context :geo_check
      respond_with :message, text: 'You are not in place right now. Try to come closer'
    else
      geo_save
      session_ending
    end
  end

  def session_ending
    checkin_session_ending if session[:command] == 'checkin'
    checkout_session_ending if session[:command] == 'checkout'
  end

  def checkin_session_ending
    respond_with :message, text: 'Your shift have successfully begun'
    session[:checkin?] = true
    session[:checkout?] = false
  end

  def checkout_session_ending
    respond_with :message, text: 'I hope you worked well today'
    respond_with :message, text: 'Have a nice day'
    respond_with :sticker, sticker: 'CAADAgADJgADwnaQBi5vOvKDgdd8Ag'
    session[:command] = nil
    session[:checkin?] = false
    session[:checkout?] = true
  end
end