require 'httparty'

class Downloader
  FILE_PATH = "https://api.telegram.org/bot#{ENV['BOT_TOKEN']}/getFile".freeze
  DOWNLOADING = "https://api.telegram.org/file/bot#{ENV['BOT_TOKEN']}".freeze

  attr_reader :file_id

  def initialize(file_id)
    @file_id = file_id
  end

  def download_file
    URI.open(image).read
  end

  private

  def image
    "#{DOWNLOADING}/#{get_file_path}"
  end

  def get_file_path
    HTTParty.get(FILE_PATH, query: { file_id: file_id }).to_h['result']['file_path']
  end
end
