module Checkout
  def checkout!(*)
    return respond_with :message, text: t(:not_registered) unless user_registered?

    return respond_with :message, text: t(:status_checkout) if checkout?

    message_for_photo_checkout
  end

  def message_for_photo_checkout
    respond_with :message, text: t(:send_photo)
    save_context :download_photo_checkout
  end

  def download_photo_checkout(*)
    session[:time_checkout] = Time.now.utc
    download_last_photo(path_name_checkout)
    message_for_geolocation_checkout
  rescue Errors::NoPhotoError
    handle_no_photo_checkout
  end

  def message_for_geolocation_checkout
    respond_with :message, text: t(:send_location)
    save_context :download_geolocation_checkout
  end
  # :reek:TooManyStatements

  def download_geolocation_checkout(*)
    if valid_geoposition?
      checkout
      download_last_geolocation(path_name_checkout)
      work_time
    else
      respond_with :message, text: t(:not_right_place)
      message_for_geolocation_checkout
    end
  rescue Errors::NoGeoLocationError
    handle_no_geolocation_checkout
  end

  private

  def path_name_checkout
    PathFile.call(payload: user_id_telegram, status: 'checkouts', time: session[:time_checkout])
  end

  def work_time
    work_time = session[:time_checkout] - session[:time_checkin]
    formatted_work_time = Time.at(work_time).utc.strftime('%H hours, %M min')
    respond_with :message, text: t(:checkout_done) + formatted_work_time.to_s
  end

  def handle_no_photo_checkout
    respond_with :message, text: t(:no_photo_in_message_error)
    message_for_photo_checkout
  end

  def handle_no_geolocation_checkout
    respond_with :message, text: t(:no_geolocation_in_message_error)
    message_for_geolocation_checkout
  end
end
