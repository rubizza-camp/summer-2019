module CheckinCommand
  def checkin!(*)
    session[:time_checkin] = Time.now.to_i
    unless redis.get(user_id_telegram)
      return respond_with :message, text: 'You are not registered'
    end
    diolog_about_photo_checkin
  end

  def diolog_about_photo_checkin
    respond_with :message, text: "I'm checkin. Send me photo"
    save_context :ask_for_photo_checkin
  end

  def diolog_about_geo_checkin
    respond_with :message, text: "I'm checkin. Send me geo"
    save_context :ask_for_geo_checkin
  end

  def ask_for_photo_checkin(*)
    download_last_photo(create_checkin_path)
    diolog_about_geo_checkin
  rescue NoMethodError
    rescue_photo_checkin
  end

  def ask_for_geo_checkin(*)
    return rescue_geo_checkin unless download_last_geo(create_checkin_path)
    respond_with :message, text: 'Have a nice day!'
  end

  private

  def rescue_photo_checkin
    respond_with :message, text: 'Are you sure you sent a photo?'
    diolog_about_photo_checkin
  end

  def rescue_geo_checkin
    respond_with :message, text: 'Are you sure you sent a location?'
    diolog_about_geo_checkin
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
