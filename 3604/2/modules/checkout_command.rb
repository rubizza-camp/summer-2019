module CheckoutCommand
  def checkout!(*)
    return respond_if_are_not_registered unless redis.get(user_id_telegram)
    return respond_if_session_checkout_or_nil unless session[:status] == 'checkin'
    session[:time_checkout] = Time.now.to_i
    session[:status] = 'checkout'
    diolog_about_photo_checkout
  end

  def respond_if_session_checkout_or_nil
    respond_with :message, text: 'First make a command /checkin'
  end

  def diolog_about_photo_checkout
    respond_with :message, text: "I'm checkout. Send me photo"
    save_context :ask_for_photo_checkout
  end

  def diolog_about_geo_checkout
    respond_with :message, text: "I'm checkout. Send me geo"
    save_context :ask_for_geo_checkout
  end

  def ask_for_photo_checkout(*)
    download_last_photo(create_checkout_path)
    diolog_about_geo_checkout
  rescue NoMethodError
    rescue_photo_checkout
  end

  def ask_for_geo_checkout(*)
    return rescue_geo_checkout unless download_last_geo(create_checkout_path)
    work_time = session[:time_checkout] - session[:time_checkin]
    work_time_string = Time.at(work_time).utc.strftime('%H hours, %M  minutes')
    respond = "Have a good relax! Your work time #{work_time_string}"
    respond_with :message, text: respond
  end

  private

  def rescue_photo_checkout
    respond_with :message, text: 'Are you sure you sent a photo?'
    diolog_about_photo_checkout
  end

  def rescue_geo_checkout
    respond_with :message, text: 'Are you sure you sent a location?'
    diolog_about_geo_checkout
  end

  def generate_checkout_path(time)
    "./public/#{user_id_telegram}/checkouts/#{time}/"
  end

  def create_checkout_path
    local_path = generate_checkout_path(Time.at(session[:time_checkout]).utc)
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
