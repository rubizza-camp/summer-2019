module Checkin
  def checkin!(*)
    return respond_with :message, text: t(:not_registered) unless user_registered?

    return respond_with :message, text: t(:status_checkin) if checkin?

    message_for_photo_checkin
  end

  def message_for_photo_checkin
    respond_with :message, text: t(:send_photo)
    save_context :download_photo_checkin
  end

  def download_photo_checkin(*)
    session[:time_checkin] = Time.now.utc
    download_last_photo(path_name_checkin)
    message_for_geolocation_checkin
  rescue Errors::NoPhotoError
    handle_no_photo_checkin
  end

  def message_for_geolocation_checkin
    respond_with :message, text: t(:send_location)
    save_context :download_geolocation_checkin
  end
  # :reek:TooManyStatements

  def download_geolocation_checkin(*)
    if valid_geoposition?
      download_last_geolocation(path_name_checkin)
      respond_with :message, text: t(:checkin_done)
      checkin
    else
      respond_with :message, text: t(:not_right_place)
      message_for_geolocation_checkin
    end
  rescue Errors::NoGeoLocationError
    handle_no_location_checkin
  end

  private

  def path_name_checkin
    PathFile.call(payload: user_id_telegram, status: 'checkins', time: session[:time_checkin])
  end

  def handle_no_photo_checkin
    respond_with :message, text: t(:no_photo_in_message_error)
    message_for_photo_checkin
  end

  def handle_no_location_checkin
    respond_with :message, text: t(:no_geolocation_in_message_error)
    message_for_geolocation_checkin
  end
end
