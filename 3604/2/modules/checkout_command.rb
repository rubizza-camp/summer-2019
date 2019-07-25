module CheckoutCommand
  def checkout!(*)
    return respond_with :message, text: I18n.t(:not_registered_response) unless user_registered?
    return response_for_session_checkout_or_nil unless session[:status] == :checkin
    session[:time_checkout] = Time.now.utc
    dialog_about_photo_checkout
  end

  def response_for_session_checkout_or_nil
    respond_with :message, text: I18n.t(:session_checkout_response)
  end

  def dialog_about_photo_checkout
    respond_with :message, text: I18n.t(:photo_dialog_response)
    save_context :ask_for_photo_checkout
  end

  def dialog_about_geo_checkout
    respond_with :message, text: I18n.t(:geo_dialog_response)
    save_context :ask_for_geo_checkout
  end

  def ask_for_photo_checkout(*)
    download_latest_photo(create_checkout_path)
    dialog_about_geo_checkout
  rescue NoMethodError
    rescue_photo_checkout
  end

  def ask_for_geo_checkout(*)
    return rescue_geo_checkout unless download_latest_geo(create_checkout_path)
    respond_with :message, text: I18n.t(:successful_checkout_response) + work_time
    session[:status] = :checkout
  end

  private

  def work_time
    Time.at(session[:time_checkout] - session[:time_checkin]).utc.strftime('%H hours, %M  minutes')
  end

  def rescue_photo_checkout
    respond_with :message, text: I18n.t(:rescue_photo_response)
    dialog_about_photo_checkout
  end

  def rescue_geo_checkout
    respond_with :message, text: I18n.t(:rescue_geo_response)
    dialog_about_geo_checkout
  end

  def generate_checkout_path(time)
    "./public/#{user_id_telegram}/checkouts/#{time}/"
  end

  def create_checkout_path
    generate_checkout_path(session[:time_checkout]).tap do |local_path|
      FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    end
  end
end
