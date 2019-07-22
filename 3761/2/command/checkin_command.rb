module CheckinCommand
  def checkin!(*)
    return respond_unreg unless student_registered?(student_number)

    return respond_uncheckout if session[:status] == :checkin

    respond_with :message, text: 'Send me selfie'
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
    session[:status] = :checkin
    response = GeolocationLoader.call(payload, session[:time_checkin], 'checkins')
    respond_with :message, text: response[:message]
    return respond_with :message, text: 'Have a good day!' if response[:status]

    save_context :checkin_geo_from_message
  end

  private

  def respond_uncheckout
    response_uncheckout = 'Oops, you have a problem. You haven\'t already /checkout'
    respond_with :message, text: response_uncheckout
  end

  def respond_unreg
    response_unreg = 'Oops, you need to register at the begin. Use command /start'
    respond_with :message, text: response_unreg
  end
end
