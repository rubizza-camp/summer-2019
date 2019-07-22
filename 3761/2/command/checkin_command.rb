module CheckinCommand
  def checkin!(*)
    return respond_with :message, text: response_unreg unless student_registered?(student_number)

    return respond_with :message, text: response_uncheckout if session[:status] == 'checkin'

    response = 'Send me selfie'
    respond_with :message, text: response
    save_context :checkin_photo_from_message
  end

  def checkin_photo_from_message(*)
    session[:time_checkin] = Time.now.to_s
    response = PhotoLoader.call(payload, session[:time_checkin], 'checkins')
    respond_with :message, text: response[:message]
    return checkin! unless response[:status]

    save_context :checkin_geo_from_message if response[:status]
  end

  def checkin_geo_from_message(*)
    session[:status] = 'checkin'
    response = GeolocationLoader.call(payload, session[:time_checkin], 'checkins')
    respond_with :message, text: response[:message]
    return respond_with :message, text: 'Have a good day!' if response[:status]

    save_context :checkin_geo_from_message
  end

  private

  def response_uncheckout
    'Oops, you have a problem. You haven\'t already /checkout'
  end

  def response_unreg
    'Oops, you need to register at the begin. Use command /start'
  end
end
