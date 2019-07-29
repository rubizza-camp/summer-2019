module CheckoutCommand
  # rubocop:disable Metrics/LineLength
  def checkout!(*)
    return respond_with :message, text: t(:need_to_register) unless student_registered?(student_number)

    return respond_with :message, text: t(:checkout_without_checkin) unless checkin?

    respond_with :message, text: t(:ask_photo)
    save_context :checkout_photo_from_message
  end

  def checkout_photo_from_message(*)
    session[:time_checkout] = Time.now.to_s
    PhotoLoader.call(payload: payload, time: session[:time_checkout], status: 'checkouts')
    respond_with :message, text: t(:ask_geolocation)
    save_context :checkout_geolocation_from_message
  rescue Errors::NoPhotoError
    handle_no_photo
  end

  def checkout_geolocation_from_message(*)
    GeolocationLoader.call(payload: payload, time: session[:time_checkout], status: 'checkouts')
    checkout
    respond_with :message, text: t(:checkout_end)
  rescue Errors::NoGeolocationError
    handle_no_geolocation
  rescue Errors::FarFromCampError
    handle_too_far_from_camp
  end

  private

  def handle_no_geolocation
    respond_with :message, text: t(:no_geolocation)
    save_context :checkout_geolocation_from_message
  end

  def handle_too_far_from_camp
    respond_with :message, text: t(:too_far_from_camp)
    save_context :checkout_geolocation_from_message
  end

  def handle_no_photo
    respond_with :message, text: t(:no_photo)
    save_context :checkout_photo_from_message
  end
  # rubocop:enable Metrics/LineLength
end
