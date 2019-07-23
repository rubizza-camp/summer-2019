module CheckoutCommand
  def checkout!(*)
    return respond_unregester unless student_registered?(student_number)

    return respond_uncheckin unless session[:status] == :checkin

    respond_ask_photo
    save_context :checkout_photo_from_message
  end

  def checkout_photo_from_message(*)
    session[:time_checkout] = Time.now.to_s
    PhotoLoader.call(payload, session[:time_checkout], 'checkouts')
    respond_ask_geo
    save_context :checkout_geo_from_message
  rescue Errors::NoPhotoError
    handle_no_photo
  end

  def checkout_geo_from_message(*)
    GeolocationLoader.call(payload, session[:time_checkout], 'checkouts')
    session[:status] = :checkout
    respond_checkout_end
  rescue Errors::NoGeolocationError
    handle_no_geolocation
  rescue Errors::FarFromCampError
    handle_too_far_from_camp
  end

  private

  def handle_no_geolocation
    respond_no_geo
    save_context :checkout_geo_from_message
  end

  def handle_too_far_from_camp
    respond_no_near_camp
    save_context :checkout_geo_from_message
  end

  def handle_no_photo
    respond_no_photo
    save_context :checkout_photo_from_message
  end
end
