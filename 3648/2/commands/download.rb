module DownloadHelper
  TOKEN = ENV.fetch('TG_BOT_TOKEN')
  GET_PATH_LINK = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id=".freeze
  GET_PHOTO_LINK = "https://api.telegram.org/file/bot#{TOKEN}/".freeze

  def create_checkin_path
    "public/#{user_id}/checkins/#{session[:time]}/"
  end

  def create_checkout_path
    "public/#{user_id}/checkouts/#{session[:time]}/"
  end

  def timestamp_checkin
    session[:time] = Time.now.utc.to_s
    download_photo(checkin_path)
  end

  def timestamp_checkout
    session[:time] = Time.now.utc.to_s
    download_photo(checkout_path)
  end

  def checkin_path
    FileUtils.mkdir_p(create_checkin_path) unless File.exist?(create_checkin_path)
    create_checkin_path
  end

  def checkout_path
    FileUtils.mkdir_p(create_checkout_path) unless File.exist?(create_checkout_path)
    create_checkout_path
  end

  def photo_file_path
    JSON.parse(photo_uri)['result']['file_path']
  end

  def photo_uri
    URI.open("#{GET_PATH_LINK}#{payload['photo'].last['file_id']}").read
  end

  def download_photo(dir_path)
    File.open(dir_path + 'selfie.jpg', 'wb') do |file|
      file << URI.open("#{GET_PHOTO_LINK}#{photo_file_path}").read
    end
  end

  def download_geo(dir_path)
    File.open(dir_path + 'geo.txt', 'wb') do |file|
      file << payload['location'].inspect
    end
  end
end
