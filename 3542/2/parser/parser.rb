require 'httparty'

class Parser
  API_URI_FOR_FILE_PATH = "https://api.telegram.org/bot#{ENV['BOT_TOKEN']}/getFile".freeze
  API_URI_FOR_DOWNLOADING = "https://api.telegram.org/file/bot#{ENV['BOT_TOKEN']}".freeze

  attr_reader :chat_session, :session_key

  def initialize(chat_session, session_key)
    @chat_session = chat_session
    @session_key = session_key
  end

  def download_file
    URI.open("#{API_URI_FOR_DOWNLOADING}/#{api_response['result']['file_path']}").read
  end

  def api_response
    HTTParty.get(API_URI_FOR_FILE_PATH, query: { file_id: file_identifier }).to_h
  end

  def file_identifier
    chat_session[session_key]['photo'].last['file_id']
  end
end
