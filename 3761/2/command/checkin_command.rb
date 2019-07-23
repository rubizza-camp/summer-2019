module CheckinCommand
  def checkin!(*)
    return respond_unregester unless student_registered?(student_number)

    return respond_uncheckout if session[:status] == :checkin

    respond_ask_photo
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
    return respond_checkin_end if response[:status]

    save_context :checkin_geo_from_message
  end
end
