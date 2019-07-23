module CheckinCommand
  def checkin!(*)
    return respond_unregester unless student_registered?(student_number)

    return respond_uncheckout if session[:status] == :checkin

    respond_ask_photo
    save_context :checkin_photo_from_message
  end

  def checkin_photo_from_message(*)
    session[:time_checkin] = Time.now.to_s
    PhotoLoader.call(payload, session[:time_checkin], 'checkins')
    respond_ask_geo
    save_context :checkin_geo_from_message
  rescue Errors::NoPhotoError
    handle_no_photo
  end

  def checkin_geo_from_message(*)
    GeolocationLoader.call(payload, session[:time_checkin], 'checkins')
    session[:status] = :checkin
    respond_checkin_end
  rescue Errors::NoGeolocationError
    handle_no_geolocation
  rescue Errors::FarFromCampError
    handle_too_far_from_camp
  end

  private

  def handle_no_geolocation
    respond_no_geo
    save_context :checkin_geo_from_message
  end

  def handle_too_far_from_camp
    respond_no_near_camp
    save_context :checkin_geo_from_message
  end

  def handle_no_photo
    respond_no_photo
    save_context :checkin_photo_from_message
  end
end
