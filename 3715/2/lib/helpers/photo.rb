BOT_API_URL = "https://api.telegram.org/bot#{ENV['TOKEN']}/getFile?file_id=".freeze
BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{ENV['TOKEN']}/".freeze
SELFIE_FILE_NAME = 'selfie.jpg'.freeze

class Photo
  include BaseCommandHelpers

  attr_reader :session, :payload

  def initialize(session, payload)
    @session = session
    @payload = payload
    session[:time] = Time.at(payload['date']).utc
    FileUtils.mkdir_p(file_path_preparation)
  end

  def photo_id
    payload['photo'].last['file_id']
  end

  def photo_file_path
    JSON.parse(URI.open(BOT_API_URL + photo_id).read, symbolize_names: true)[:result][:file_path]
  end

  def download_photo
    telegram_path = photo_file_path
    local_folder_path = file_path_preparation
    File.open(local_folder_path + SELFIE_FILE_NAME, 'wb') do |file|
      file << URI.open(BOT_DOWNLOAD_API_URL + telegram_path).read
    end
  end
end
