# frozen_string_literal: true

require 'fileutils'
require 'open-uri'
require 'json'
module DownloadHelpers
  private

  TOKEN = ENV.fetch('ACCESS_BOT_TOKEN')
  BOT_API_URL = "https://api.telegram.org/bot#{TOKEN}/"
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/"
  GET_PATH_URL = 'getFile?file_id='

  def download_last_photo(path)
    telegram_path = photo_file_path
    File.open(path + 'selfie.jpg', 'wb') do |file|
      file << URI.open(BOT_DOWNLOAD_API_URL + telegram_path).read
    end
  end

  def download_last_geo(path)
    File.open(path + 'geo.txt', 'wb') do |file|
      file << geo_parse.inspect
    end
  end

  def generate_checkin_path(timestamp)
    "./public/#{user_id}/checkins/#{timestamp}/"
  end

  def generate_checkout_path(timestamp)
    "./public/#{user_id}/checkouts/#{timestamp}/"
  end

  def photo_file_path
    JSON.parse(URI.open(BOT_API_URL + GET_PATH_URL + payload['photo'].last['file_id'])
                 .read, symbolize_names: true)[:result][:file_path]
  end

  def geo_parse
    payload['location']
  end
end
