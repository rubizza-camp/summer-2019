module DownloadImageHelper
  Dotenv.load
  TOKEN = ENV['TOKEN']

  API_URL_TELEGRAM = "https://api.telegram.org/bot#{TOKEN}/".freeze
  API_URL_TELEGRAM_FILE = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  GET_FILE_URL = 'getFile?file_id='.freeze
  FILE_SELFIE = 'selfie.jpg'.freeze

  def download_last_photo(local_path)
    File.open(local_path + FILE_SELFIE, 'w') do |file|
      file << URI.open(API_URL_TELEGRAM_FILE + photo_file_path).read
    end
  end

  def photo_file_path
    raise Errors::NoPhotoError unless payload['photo']

    JSON.parse(URI.open(url_json_file).read, symbolize_names: true)[:result][:file_path]
  end

  def url_json_file
    @url_json_file ||= API_URL_TELEGRAM + GET_FILE_URL + parse_image
  end

  def parse_image
    payload['photo'].last['file_id']
  end
end
