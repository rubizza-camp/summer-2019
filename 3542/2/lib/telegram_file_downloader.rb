require 'httparty'

class TelegramFileDownloader
  API_URI_FOR_FILE_PATH = "https://api.telegram.org/bot#{ENV['BOT_TOKEN']}/getFile".freeze
  API_URI_FOR_DOWNLOADING = "https://api.telegram.org/file/bot#{ENV['BOT_TOKEN']}".freeze

  attr_reader :file_identifier

  def initialize(file_identifier)
    @file_identifier = file_identifier
  end

  def download_file
    URI.open(image_uri).read
  end

  def image_uri
    "#{API_URI_FOR_DOWNLOADING}/#{telegram_api_response['result']['file_path']}"
  end

  def telegram_api_response
    HTTParty.get(API_URI_FOR_FILE_PATH, query: { file_id: file_identifier }).to_h
  end
end
