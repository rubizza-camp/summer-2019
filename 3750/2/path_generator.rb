class PathGenerator
  TOKEN = ENV['BOT_TOKEN']

  BOT_API_URL = "https://api.telegram.org/bot#{TOKEN}/".freeze
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  GET_PATH_URL = 'getFile?file_id='.freeze

  def initialize(session, payload)
    @timestamp = session[:timestamp]
    @command = session[:command]
    @id = session[:id]
    @payload = payload
  end

  attr_reader :timestamp, :command, :id, :payload

  def save_path
    return checkin_path if command == 'checkin'
    checkout_path
  end

  def download_path
    "#{BOT_DOWNLOAD_API_URL}#{photo_download_path}"
  end

  private

  def photo_download_path
    JSON.parse(URI.open(path_request_url).read, symbolize_names: true)
        .fetch(:result, {}).fetch(:file_path)
  end

  def photo_id
    payload.fetch('photo', [{}]).last.fetch('file_id')
  end

  def checkin_path
    "./public/#{id}/checkins/#{timestamp}/"
  end

  def checkout_path
    "./public/#{id}/checkouts/#{timestamp}/"
  end

  def path_request_url
    "#{BOT_API_URL}#{GET_PATH_URL}#{photo_id}"
  end
end
