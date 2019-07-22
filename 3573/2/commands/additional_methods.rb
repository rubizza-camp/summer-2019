require 'redis'

module AddMethods

  TOKEN = '860071708:AAGrfhtaGXROhZJGjP-Bml5tIf0UoKquBM0'
  # --------------------------------------------------
  def response_if_not_registered
    respond_with :message, text: "You're not registered"
  end

  def redis
    @redis ||= Redis.new
  end

  def user_id_telegram
    @user_id_telegram ||= payload['from']['id']
  end
  #----------------------------------------------------------------------------
  API_URL_TELEGRAM = "https://api.telegram.org/bot#{TOKEN}/"
  API_URL_TELEGRAM_FILE = "https://api.telegram.org/file/bot#{TOKEN}/"
  GET_FILE_URL = 'getFile?file_id='

  def download_last_photo(local_path)
    File.open(local_path + 'selfie.jpg', 'w') do  |file|
      file << URI.open(API_URL_TELEGRAM_FILE + photo_file_path).read
    end
  end

  def photo_file_path
    JSON.parse(URI.open(url_json_about_file).read, symbolize_names: true)[:result][:file_path]
  end

  def url_json_about_file
    @url_json_about_filr ||= API_URL_TELEGRAM + GET_FILE_URL + payload['photo'].last['file_id']
  end
  # -------------------------------------------------------------------------------------------------
  def geo_parse
    @geo_parse ||= payload['location']
  end

  def validator_geo
    (53.914264..53.916233).cover?(geo_parse['latitude'].to_f)
  end

  def download_last_geo(local_path)
    File.open(local_path + 'geo.txt', 'w') { |file| file.write(geo_parse.inspect) } if geo_parse
  end
end
