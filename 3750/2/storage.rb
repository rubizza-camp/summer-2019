class Storage
  TOKEN = ENV['BOT_TOKEN']

  BOT_API_URL = "https://api.telegram.org/bot#{TOKEN}/".freeze
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  GET_PATH_URL = 'getFile?file_id='.freeze

  def self.save_photo(session, payload)
    new(session, payload).save_photo
  end

  def self.save_location(session, payload)
    new(session, payload).save_location
  end

  def initialize(session, payload)
    @session = session
    @payload = payload
  end

  attr_reader :session, :payload
  attr_reader :path

  def save_photo
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    @path = "#{dir}photo.jpg"
    File.open(path, 'wb') do |file|
      file << URI.open(download_path).read
    end
  end

  def save_location
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    @path = "#{dir}location.txt"
    File.open(path, 'wb') do |file|
      file << payload['location'].inspect
    end
  end

  private

  def dir
    @dir ||= "./public/#{session['id']}/#{session['command']}s/#{session['timestamp']}/"
  end

  def download_path
    "#{BOT_DOWNLOAD_API_URL}#{photo_download_path}"
  end

  def photo_download_path
    JSON.parse(URI.open(path_request_url).read, symbolize_names: true)
        .fetch(:result, {}).fetch(:file_path)
  end

  def path_request_url
    "#{BOT_API_URL}#{GET_PATH_URL}#{photo_id}"
  end

  def photo_id
    payload.fetch('photo', [{}]).last.fetch('file_id')
  end
end
