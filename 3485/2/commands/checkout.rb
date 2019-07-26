# frozen_string_literal: true

# checkout and create path for data
module Checkout
  def checkout!(*)
    return respond_if_are_not_registered unless redis.get(user_id_telegram)
    return respond_if_session_checkout_or_nil unless session[:status] == 'checkin'

    session[:time_checkout] = Time.now
    session[:status] = 'checkout'
    photo_checkout
  end

  def respond_if_session_checkout_or_nil
    respond_with :message, text: 'Зачекинься сразу /checkin'
  end

  def photo_checkout
    respond_with :message, text: 'Скиньте фото!'
    save_context :ask_for_photo_checkout
  end

  def geo_checkout
    respond_with :message, text: 'Нужна геолокация!'
    save_context :ask_for_geo_checkout
  end

  def ask_for_photo_checkout(*)
    download_photo(create_checkout_path)
    geo_checkout
  rescue NoMethodError
    rescue_photo_checkout
  end

  def ask_for_geo_checkout(*)
    return rescue_geo_checkout unless download_geo(create_checkout_path)

    work_time = session[:time_checkout] - session[:time_checkin]
    work_time_string = Time.at(work_time).utc.strftime('%H часов, %M  минут')
    respond = "Чёт мало работал, всего #{work_time_string}"
    respond_with :message, text: respond
  end

  private

  def rescue_photo_checkout
    respond_with :message, text: 'Нужна фотография!'
    photo_checkout
  end

  def rescue_geo_checkout
    respond_with :message, text: 'Это не координаты!'
    geo_checkout
  end

  def checkout_path
    "./public/#{user_id_telegram}/checkouts/#{session[:time_checkout]}/"
  end

  def create_checkout_path
    local_path = checkout_path
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
