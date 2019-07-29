Dir[File.join('.', 'helpers', '*.rb')].each { |file| require file }

class PhotoLoader
  include Helper

  Dotenv.load
  TOKEN = ENV['TOKEN']

  BOT_API_URL = "https://api.telegram.org/bot#{TOKEN}/".freeze
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  GET_PATH_URL = 'getFile?file_id='.freeze
  FILE_FOR_SELFIE = '/selfie.jpg'.freeze

  attr_reader :payload, :time, :status

  def initialize(payload, time, status)
    @payload = payload
    @time = time
    @status = status
  end

  def self.call(payload:, time:, status:)
    new(payload, time, status).call
  end

  def call
    download_last_photo
  end

  private

  def download_last_photo
    telegram_path = photo_file_path
    FileUtils.mkdir_p(path_to_storage) unless File.exist?(path_to_storage)
    File.open(path_to_storage + FILE_FOR_SELFIE, 'wb') do |file|
      file << URI.open(BOT_DOWNLOAD_API_URL + telegram_path).read
    end
  end

  def photo_file_path
    raise Errors::NoPhotoError unless payload['photo']

    JSON.parse(URI.open(BOT_API_URL + GET_PATH_URL + payload['photo'].last['file_id'])
                 .read, symbolize_names: true)[:result][:file_path]
  end

  def path_to_storage
    path(status, time)
  end
end
