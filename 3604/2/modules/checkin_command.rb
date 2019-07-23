require_relative 'responses_helper.rb'

module CheckinCommand
  include ResponsesHelper

  def checkin!(*)
    return respond_with :message, text: USER_ARE_NOT_REGISTERED_RESPONSE unless user_registered?
    return response_for_session_checkin if session[:status] == CHECKIN_STRING
    session[:time_checkin] = Time.now.utc
    dialog_about_photo_checkin
  end

  def response_for_session_checkin
    respond_with :message, text: SESSION_CHECKIN_RESPONSE
  end

  def dialog_about_photo_checkin
    respond_with :message, text: PHOTO_DIALOG_RESPONSE
    save_context :ask_for_photo_checkin
  end

  def dialog_about_geo_checkin
    respond_with :message, text: GEO_DIALOG_RESPONSE
    save_context :ask_for_geo_checkin
  end

  def ask_for_photo_checkin(*)
    download_last_photo(create_checkin_path)
    dialog_about_geo_checkin
  rescue NoMethodError
    rescue_photo_checkin
  end

  def ask_for_geo_checkin(*)
    return rescue_geo_checkin unless download_last_geo(create_checkin_path)
    respond_with :message, text: SUCCESSFUL_CHECKIN_RESPONSE
    session[:status] = CHECKIN_STRING
  end

  private

  def rescue_photo_checkin
    respond_with :message, text: RESCUE_PHOTO_RESPONSE
    dialog_about_photo_checkin
  end

  def rescue_geo_checkin
    respond_with :message, text: RESCUE_GEO_RESPONSE
    dialog_about_geo_checkin
  end

  def generate_checkin_path(time)
    "./public/#{user_id_telegram}/checkins/#{time}/"
  end

  def create_checkin_path
    local_path = generate_checkin_path(session[:time_checkin])
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
