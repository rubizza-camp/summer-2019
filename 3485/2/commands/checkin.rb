# frozen_string_literal: true

require_relative 'start.rb'

# checkin and create path for data
module Checkin
  def checkin!(*)
    session[:time_checkin] = Time.now
    return respond_with :message, text: respond unless redis.get(user_id_telegram)

    session[:status] = 'checkin'
    checkin_photo
  end

  def checkin_photo
    respond_with :message, text: 'Скиньте фото!'
    save_context :ask_for_photo_checkin
  end

  def checkin_geo
    respond_with :message, text: 'Ваша геолокация?'
    save_context :ask_for_geo_checkin
  end

  def ask_for_photo_checkin(*)
    download_photo(create_checkin_path)
    checkin_geo
  rescue NoMethodError
    rescue_photo_checkin
  end

  def ask_for_geo_checkin(*)
    return rescue_geo_checkin unless download_geo(create_checkin_path)

    respond_with :message, text: 'Time to work'
  end

  private

  def rescue_photo_checkin
    respond_with :message, text: 'Это фото?'
    checkin_photo
  end

  def rescue_geo_checkin
    respond_with :message, text: 'Нужна геолокация!'
    checkin_geo
  end

  def generate_checkin_path
    "./public/#{user_id_telegram}/checkins/#{session[:time_checkin]}/"
  end

  def create_checkin_path
    local_path = generate_checkin_path
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
