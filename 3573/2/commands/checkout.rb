module Checkout
  def checkout!(*)
    return response_if_not_registered unless user_registered?

    return response_if_session_checkout if checkout?

    message_for_photo_checkout
  end

  def response_if_session_checkout
    respond_with :message, text: t(:status_checkout)
  end

  def message_for_photo_checkout
    respond_with :message, text: t(:send_photo)
    save_context :download_photo_checkout
  end

  def download_photo_checkout(*)
    download_last_photo(create_checkout_path)
    message_for_geo_checkout
  rescue Errors::NoPhotoError
    rescue_photo_checkout
  end

  def message_for_geo_checkout
    respond_with :message, text: t(:send_location)
    save_context :download_geo_checkout
  end
  # :reek:TooManyStatements

  def download_geo_checkout(*)
    if valid_geo?
      checkout_parameters
      download_last_geo(create_checkout_path)
      work_time
    else
      respond_with :message, text: t(:not_right_place)
      message_for_geo_checkout
    end
  rescue Errors::NoGeoError
    rescue_geo_checkout
  end

  def work_time
    work_time = session[:time_checkout] - session[:time_checkin]
    formated_work_time = Time.at(work_time).utc.strftime('%H hours, %M min')
    respond_with :message, text: t(:checkout_done) + formated_work_time.to_s
  end

  def checkout_parameters
    session[:time_checkout] = Time.now.utc
    checkout
  end

  private

  def rescue_photo_checkout
    respond_with :message, text: t(:message_rescue_photo)
    message_for_photo_checkout
  end

  def rescue_geo_checkout
    respond_with :message, text: t(:message_rescue_location)
    message_for_geo_checkout
  end
end
