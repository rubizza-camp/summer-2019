# frozen_string_literal: true

require 'redis'
require 'dotenv/load'

# load geo and photo
module Helper
  TOKEN = ENV['TOKEN']
  API_TELEGRAM = "https://api.telegram.org/bot#{TOKEN}/"
  API_TELEGRAM_FILE = "https://api.telegram.org/file/bot#{TOKEN}/"
  GET_FILE = 'getFile?file_id='

  private

  def redis
    @redis ||= Redis.new
  end

  def user_id_telegram
    @user_id_telegram ||= payload['from']['id']
  end

  def download_photo(local_path)
    File.open(local_path + 'eblo.jpg', 'w') do |file|
      file << URI.open(API_TELEGRAM_FILE + photo_file_path).read
    end
  end

  def download_geo(local_path)
    File.open(local_path + 'geo.txt', 'w') { |file| file.write(geo_parse.inspect) } if geo_parse
  end

  def photo_file_path
    JSON.parse(URI.open(url_json_about_file).read, symbolize_names: true)[:result][:file_path]
  end

  def url_json_about_file
    @url_json_about_file ||= API_TELEGRAM + GET_FILE + payload['photo'].last['file_id']
  end

  def geo_parse
    @geo_parse ||= payload['location']
  end
end
