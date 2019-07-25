module CheckinCommand
  def checkin!(*)
    return respond_with :message, text: I18n.t(:not_registered_response) unless user_registered?
    return response_for_session_checkin if session[:status] == :checkin
    session[:time_checkin] = Time.now.utc
    dialog_about_photo_checkin
  end

  def response_for_session_checkin
    respond_with :message, text: I18n.t(:session_checkin_response)
  end

  def dialog_about_photo_checkin
    respond_with :message, text: I18n.t(:photo_dialog_response)
    save_context :ask_for_photo_checkin
  end

  def dialog_about_geo_checkin
    respond_with :message, text: I18n.t(:geo_dialog_response)
    save_context :ask_for_geo_checkin
  end

  def ask_for_photo_checkin(*)
    download_latest_photo(create_checkin_path)
    dialog_about_geo_checkin
  rescue NoMethodError
    rescue_photo_checkin
  end

  def ask_for_geo_checkin(*)
    return rescue_geo_checkin unless download_latest_geo(create_checkin_path)
    respond_with :message, text: I18n.t(:successful_checkin_response)
    session[:status] = :checkin
  end

  private

  def rescue_photo_checkin
    respond_with :message, text: I18n.t(:rescue_photo_response)
    dialog_about_photo_checkin
  end

  def rescue_geo_checkin
    respond_with :message, text: I18n.t(:rescue_geo_response)
    dialog_about_geo_checkin
  end

  def generate_checkin_path(time)
    "./public/#{user_id_telegram}/checkins/#{time}/"
  end

  def create_checkin_path
    generate_checkin_path(session[:time_checkin]).tap do |local_path|
      FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    end
  end
end
