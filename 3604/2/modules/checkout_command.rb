require_relative 'responses_helper.rb'

module CheckoutCommand
  include ResponsesHelper

  def checkout!(*)
    return respond_with :message, text: USER_ARE_NOT_REGISTERED_RESPONSE unless user_registered?
    return response_for_session_checkout_or_nil unless session[:status] == CHECKIN_STRING
    session[:time_checkout] = Time.now.utc
    dialog_about_photo_checkout
  end

  def response_for_session_checkout_or_nil
    respond_with :message, text: SESSION_CHECKOUT_RESPONSE
  end

  def dialog_about_photo_checkout
    respond_with :message, text: PHOTO_DIALOG_RESPONSE
    save_context :ask_for_photo_checkout
  end

  def dialog_about_geo_checkout
    respond_with :message, text: GEO_DIALOG_RESPONSE
    save_context :ask_for_geo_checkout
  end

  def ask_for_photo_checkout(*)
    download_last_photo(create_checkout_path)
    dialog_about_geo_checkout
  rescue NoMethodError
    rescue_photo_checkout
  end

  def ask_for_geo_checkout(*)
    return rescue_geo_checkout unless download_last_geo(create_checkout_path)
    respond = SUCCESSFUL_CHECKOUT_RESPONSE + work_time
    respond_with :message, text: respond
    session[:status] = CHECKOUT_STRING
  end

  private

  def work_time
    Time.at(session[:time_checkout] - session[:time_checkin]).utc.strftime('%H hours, %M  minutes')
  end

  def rescue_photo_checkout
    respond_with :message, text: RESCUE_PHOTO_RESPONSE
    dialog_about_photo_checkout
  end

  def rescue_geo_checkout
    respond_with :message, text: RESCUE_GEO_RESPONSE
    dialog_about_geo_checkout
  end

  def generate_checkout_path(time)
    "./public/#{user_id_telegram}/checkouts/#{time}/"
  end

  def create_checkout_path
    local_path = generate_checkout_path(session[:time_checkout])
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
