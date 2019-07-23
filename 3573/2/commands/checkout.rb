module Checkout
  def checkout!(*)
    return response_if_not_registered unless redis.get(user_id_telegram)
    return response_if_session_checkout if session[:status] == 'checkout'
    message_for_photo_checkout
  end

  def response_if_session_checkout
    respond_with :message, text: "You session status: 'checkout'. First use command /checkin"
  end

  def message_for_photo_checkout
    respond_with :message, text: 'Send me photo!'
    save_context :download_photo_checkout
  end

  def download_photo_checkout(*)
    download_last_photo(create_checkout_path)
    message_for_geo_checkout
  rescue NoMethodError
    rescue_photo_checkout
  end

  def message_for_geo_checkout
    respond_with :message, text: 'Send me your location'
    save_context :download_geo_checkout
  end
  # :reek:TooManyStatements
  def download_geo_checkout(*)
    if validator_geo == false
      respond_with :message, text: 'You are not right place. Try again'
      message_for_geo_checkout
    else
      download_last_geo(create_checkout_path)
      checkout_parameters
      work_time

    end
  rescue NoMethodError
    rescue_geo_checkout
  end

  def work_time
    work_time = session[:time_checkout] - session[:time_checkin]
    work_time_in_string = Time.at(work_time).utc.strftime('%H hours, %M min')
    respond = "Your work time #{work_time_in_string}"
    respond_with :message, text: respond
  end

  def checkout_parameters
    session[:time_checkout] = Time.now.utc
    session[:status] = 'checkout'
  end

  def rescue_photo_checkout
    respond_with :message, text: 'Are you sure, you sent your photo?'
    message_for_photo_checkout
  end

  def rescue_geo_checkout
    respond_with :message, text: 'Are you sure, you sent your location?'
    message_for_geo_checkout
  end

  def generate_checkout_path(time)
    "./public/#{user_id_telegram}/checkouts/#{time}"
  end

  def create_checkout_path
    local_path = generate_checkout_path(Time.at(session[:time_checkout]).utc)
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
