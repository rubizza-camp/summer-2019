module Checkin
  def checkin!(*)
    return response_if_not_registered unless redis.get(user_id_telegram)
    return response_if_session_checkin if session[:status] == 'checkin'
    message_for_photo_checkin
  end

  def response_if_session_checkin
    respond_with :message, text: t(:status_checkin)
  end

  def message_for_photo_checkin
    respond_with :message, text: t(:send_photo)
    save_context :download_photo_checkin
  end

  def download_photo_checkin(*)
    download_last_photo(create_checkin_path)
    message_for_geo_checkin
  rescue NoMethodError
    rescue_photo_checkin
  end

  def message_for_geo_checkin
    respond_with :message, text: t(:send_location)
    save_context :download_geo_checkin
  end
  # :reek:TooManyStatements

  def download_geo_checkin(*)
    if validator_geo
      download_last_geo(create_checkin_path)
      respond_with :message, text: t(:checkin_done)
      checkin_parameters
    else
      respond_with :message, text: t(:not_right_place)
      message_for_geo_checkin
    end
  rescue NoMethodError
    rescue_geo_checkin
  end

  def checkin_parameters
    session[:time_checkin] = Time.now.utc
    session[:status] = 'checkin'
  end

  def rescue_photo_checkin
    respond_with :message, text: t(:message_rescue_photo)
    message_for_photo_checkin
  end

  def rescue_geo_checkin
    respond_with :message, text: t(:message_rescue_location)
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
