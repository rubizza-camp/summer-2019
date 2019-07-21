module Helpers
  BOT_API_URL = "https://api.telegram.org/bot#{TOKEN}/".freeze
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  GET_PATH_URL = 'getFile?file_id='.freeze

  def registered?
    return true if session.key?(:number)
    respond_with :message, text: "Stay still, I don't know who you are!"
    respond_with :message, text: "You got to register first.\n
    This will be easy, just type in /start command and I'll check you number in list"
    false
  end

  def checkin?
    session[:checkin?]
  end

  def generate_path(timestamp)
    return checkin_path(timestamp) if session[:command] == 'checkin'
    checkout_path(timestamp)
  end

  def checkin_path(timestamp)
    "./public/#{from['id']}/checkins/#{timestamp}/"
  end

  def checkout_path(timestamp)
    "./public/#{from['id']}/checkouts/#{timestamp}/"
  end

  def create_path_request_url
    BOT_API_URL + GET_PATH_URL + photo_id
  end

  def photo_download_path
    JSON.parse(URI.open(create_path_request_url).read, symbolize_names: true)
        .fetch(:result, {}).fetch(:file_path)
  end

  def photo_id
    payload.fetch('photo', [{}]).last.fetch('file_id')
  end

  def photo_save
    session[:timestamp] = Time.now.getutc.to_i
    path = generate_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)
    File.open(path + 'photo.jpg', 'wb') do |file|
      file << URI.open(BOT_DOWNLOAD_API_URL + photo_download_path).read
    end
  end

  def geo_save
    path = generate_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)
    File.open(path + 'geo.txt', 'wb') do |file|
      file << payload['location'].inspect
    end
  end
end
