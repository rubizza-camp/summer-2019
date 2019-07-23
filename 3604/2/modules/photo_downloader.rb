# frozen_string_literal: true

module PhotoDownloader
  Dotenv.load
  TOKEN = ENV['TOKEN']
  API_URL_TELEGRAM = "https://api.telegram.org/bot#{TOKEN}/"
  API_URL_TELEGRAM_FILE = "https://api.telegram.org/file/bot#{TOKEN}/"
  GET_FILE_URL = 'getFile?file_id='

  def download_last_photo(local_path)
    File.open(local_path + 'selfie.jpg', 'w') do |file|
      file << URI.open(API_URL_TELEGRAM_FILE + photo_file_path).read
    end
  end

  def photo_file_path
    JSON.parse(URI.open(url_json_about_file).read, symbolize_names: true).dig(:result, :file_path)
  end

  def url_json_about_file
    @url_json_about_file ||= API_URL_TELEGRAM + GET_FILE_URL + payload.dig('photo', -1, 'file_id')
  end
end
