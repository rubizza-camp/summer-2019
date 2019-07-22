require './helper/helper.rb'

class PhotoLoader
  include Helper

  BOT_API_URL = "https://api.telegram.org/bot#{TOKEN}/".freeze
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  GET_PATH_URL = 'getFile?file_id='.freeze

  attr_reader :payload, :time, :status

  def initialize(payload, time, status)
    @payload = payload
    @time = time
    @status = status
  end

  def self.call(payload, time, status)
    new(payload, time, status).call
  end

  def call
    download_last_photo
    response_successfull
  rescue NoMethodError
    response_no_photo
  end

  private

  def download_last_photo
    telegram_path = photo_file_path
    FileUtils.mkdir_p(help_path) unless File.exist?(help_path)
    File.open(help_path + '/selfie.jpg', 'wb') do |file|
      file << URI.open(BOT_DOWNLOAD_API_URL + telegram_path).read
    end
  end

  def photo_file_path
    JSON.parse(URI.open(BOT_API_URL + GET_PATH_URL + payload['photo'].last['file_id'])
                 .read, symbolize_names: true)[:result][:file_path]
  end

  def help_path
    path(status, time)
  end

  def response_successfull
    response = 'Great!!! But... I don\'t believe you. Send me your geolocation'
    { status: true, message: response }
  end

  def response_no_photo
    response = 'Are you sure that it is photo???'
    { status: false, message: response }
  end
end
