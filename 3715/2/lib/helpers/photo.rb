module Photo
  TOKEN = File.read('data/secret.yml').strip.freeze
  BOT_API_URL = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id=".freeze
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  SELFIE_FILE_NAME = 'selfie.jpg'.freeze

  def timestamp
    session[:time] = Time.at(payload['date']).utc
  end

  def photo_id
    payload['photo'].last['file_id']
  end

  def photo_file_path
    JSON.parse(URI.open(BOT_API_URL + photo_id).read, symbolize_names: true)[:result][:file_path]
  end

  def download_photo(path)
    telegram_path = photo_file_path
    File.open(path + SELFIE_FILE_NAME, 'wb') do |file|
      file << URI.open(BOT_DOWNLOAD_API_URL + telegram_path).read
    end
  end
end
