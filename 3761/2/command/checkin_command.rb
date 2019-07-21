module CheckinCommand
  def checkin!(*)
    response = 'Oops, You need to register at the begin. Use command /start'
    return respond_with :message, text: response unless student_registered?(student_number)

    response = 'Send me selfie'
    respond_with :message, text: response
    save_context :checkin_photo_from_message
  end

  def checkin_photo_from_message(*)
    session['time_checkin'] = Time.now.to_s
    response = PhotoLoader.call(payload, session['time_checkin'], 'checkins')
    respond_with :message, text: response[:message]
    return checkin! unless response[:status]

    save_context :checkin_geo_from_message if response[:status]
  end

  def checkin_geo_from_message(*)
    response = GeolocationLoader.call(payload, session['time_checkin'], 'checkins')
    respond_with :message, text: response[:message]
    return respond_with :message, text: 'Have a good day!' if response[:status]

    save_context :checkin_geo_from_message
  end
end
