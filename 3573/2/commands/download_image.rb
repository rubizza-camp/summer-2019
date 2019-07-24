module DownloadImage
  Dotenv.load
  TOKEN = ENV['TOKEN']

  API_URL_TELEGRAM = "https://api.telegram.org/bot#{TOKEN}/".freeze
  API_URL_TELEGRAM_FILE = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  GET_FILE_URL = 'getFile?file_id='.freeze

  def download_last_photo(local_path)
    File.open(local_path + 'selfie.jpg', 'w') do |file|
      file << URI.open(API_URL_TELEGRAM_FILE + photo_file_path).read
    end
  end

  def photo_file_path
    JSON.parse(URI.open(url_json_file).read, symbolize_names: true)[:result][:file_path]
  end

  def parse_image
    payload['photo'].last['file_id']
  end

  def url_json_file
    @url_json_file ||= API_URL_TELEGRAM + GET_FILE_URL + parse_image
  end
end
