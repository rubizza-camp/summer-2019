require 'httparty'

class TelegramFileDownloader
  API_URI_FOR_FILE_PATH = "https://api.telegram.org/bot#{ENV['BOT_TOKEN']}/getFile".freeze
  API_URI_FOR_DOWNLOADING = "https://api.telegram.org/file/bot#{ENV['BOT_TOKEN']}".freeze

  attr_reader :file_id

  def initialize(file_id)
    @file_id = file_id
  end

  def download_file
    URI.open(image_uri).read
  end

  def image_uri
    "#{API_URI_FOR_DOWNLOADING}/#{fetch_file_path}"
  end

  def fetch_file_path
    HTTParty.get(API_URI_FOR_FILE_PATH, query: { file_id: file_id }).to_h['result']['file_path']
  end
end
