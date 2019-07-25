require 'httparty'
require 'dotenv/load'

class FileDownloader
  API_URI_FILE_PATH = "https://api.telegram.org/bot#{ENV['TOKEN']}/getFile".freeze
  API_URI_DOWNLOADING = "https://api.telegram.org/file/bot#{ENV['TOKEN']}".freeze

  attr_reader :file_definer

  def initialize(file_definer)
    @file_definer = file_definer
  end

  def download_file
    URI.open(image_uri).read
  end

  def image_uri
    "#{API_URI_DOWNLOADING}/#{fetch_path['result']['file_path']}"
  end

  def fetch_path
    HTTParty.get(API_URI_FILE_PATH, query: { file_id: file_definer }).to_h
  end
end
