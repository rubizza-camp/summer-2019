# frozen_string_literal: true

require_relative 'start.rb'

# checkin and create path for data
module Checkin
  def checkin!(*)
    session[:time_checkin] = Time.now.to_i
    respond = 'попался'
    return respond_with :message, text: respond unless redis.get(user_id_telegram)

    session[:status] = 'checkin'
    checkin_photo
  end

  def checkin_photo
    respond_with :message, text: 'скинь фото'
    save_context :ask_for_photo_checkin
  end

  def checkin_geo
    respond_with :message, text: 'Твоя гео лок?'
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

    respond_with :message, text: 'time to work'
  end

  private

  def rescue_photo_checkin
    respond_with :message, text: 'это фото?'
    checkin_photo
  end

  def rescue_geo_checkin
    respond_with :message, text: 'пиши нормально'
    checkin_geo
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
