require 'httparty'

class ImageLoader
  FILE_PATH = "https://api.telegram.org/bot#{ENV['TELEGRAM_BOT_TOKEN']}/getFile".freeze
  FILE_DOWNLOAD = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_BOT_TOKEN']}".freeze

  attr_reader :session, :session_key, :payload

  def initialize(session, session_key)
    @session = session
    @session_key = session_key
  end

  def download_file
    URI.open(image_uri).read
  end

  def image_uri
    "#{FILE_DOWNLOAD}/#{telegram_response['result']['file_path']}"
  end

  def telegram_response
    HTTParty.get(FILE_PATH, query: { file_id: session[session_key]['photo'] }).to_h
  end
end
