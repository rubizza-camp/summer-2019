module PathGenerator
  TOKEN = ENV['BOT_TOKEN']

  BOT_API_URL = "https://api.telegram.org/bot#{TOKEN}/".freeze
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  GET_PATH_URL = 'getFile?file_id='.freeze

  def save_path(timestamp)
    return checkin_path(timestamp) if session[:command] == 'checkin'
    checkout_path(timestamp)
  end

  def download_path
    BOT_DOWNLOAD_API_URL + photo_download_path
  end

  private

  def photo_download_path
    JSON.parse(URI.open(path_request_url).read, symbolize_names: true)
        .fetch(:result, {}).fetch(:file_path)
  end

  def photo_id
    payload.fetch('photo', [{}]).last.fetch('file_id')
  end

  def checkin_path(timestamp)
    "./public/#{from['id']}/checkins/#{timestamp}/"
  end

  def checkout_path(timestamp)
    "./public/#{from['id']}/checkouts/#{timestamp}/"
  end

  def path_request_url
    BOT_API_URL + GET_PATH_URL + photo_id
  end
end