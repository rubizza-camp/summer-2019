module Checkin
  def checkin!(*)
    return response_if_not_registered unless redis.get(user_id_telegram)
    return response_if_session_checkin if session[:status] == 'checkin'
    message_for_photo_checkin
  end

  def response_if_session_checkin
    respond_with :message, text: "You session status: 'checkin'. First use command /checkout"
  end

  def message_for_photo_checkin
    respond_with :message, text: 'Send me your photo'
    save_context :download_photo_checkin
  end

  def download_photo_checkin(*)
    download_last_photo(create_checkin_path)
    message_for_geo_checkin
  rescue NoMethodError
    rescue_photo_checkin
  end

  def message_for_geo_checkin
    respond_with :message, text: 'Send me your location'
    save_context :download_geo_checkin
  end
  # :reek:TooManyStatements

  def download_geo_checkin(*)
    if validator_geo == false
      respond_with :message, text: 'You are not right place. Try again'
      message_for_geo_checkin
    else
      download_last_geo(create_checkin_path)
      respond_with :message, text: 'OK, checkin is done. You can work!'
      checkin_parameters
    end
  rescue NoMethodError
    rescue_geo_checkin
  end

  def checkin_parameters
    session[:time_checkin] = Time.now.utc
    session[:status] = 'checkin'
  end

  def rescue_photo_checkin
    respond_with :message, text: 'Are you sure, you sent your photo?'
    message_for_photo_checkin
  end

  def rescue_geo_checkin
    respond_with :message, text: 'Are you sure, you sent your location?'
    message_for_geo_checkin
  end

  def generate_checkin_path(time)
    "./public/#{user_id_telegram}/checkins/#{time}/"
  end

  def create_checkin_path
    local_path = generate_checkin_path(Time.at(session[:time_checkin]).utc)
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
