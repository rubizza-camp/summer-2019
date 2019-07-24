require 'fileutils'
require 'open-uri'

class UserUpload
  attr_reader :action, :telegram_id

  def initialize(action, telegram_id)
    @action = action
    @telegram_id = telegram_id
    create_uploads_folder
  end

  def save_photo(file_id)
    path = get_photo_path(file_id)

    File.open(photo_path, 'wb') do |file|
      file << download_photo(path)
    end
  end

  def save_location(coordinates)
    File.open(location_path, 'wb') do |file|
      file << coordinates
    end
  end

  def rename_current
    checkin_time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    new_name = uploads_folder.sub('/current', "/#{checkin_time}")
    FileUtils.mv(uploads_folder, new_name)
  end

  private

  def create_uploads_folder
    FileUtils.mkdir_p(uploads_folder)
  end

  def uploads_folder
    "public/#{telegram_id}/#{action}s/current"
  end

  def photo_path
    "#{uploads_folder}/photo.jpg"
  end

  def location_path
    "#{uploads_folder}/location.txt"
  end

  def get_photo_path(file_id)
    responce = open("https://api.telegram.org/bot#{BOT_TOKEN}/getFile?file_id=#{file_id}").read
    JSON.parse(responce)['result']['file_path']
  end

  def download_photo(file_path)
    open("https://api.telegram.org/file/bot#{BOT_TOKEN}/#{file_path}").read
  end
end
