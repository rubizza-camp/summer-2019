require_relative '../helper_module/student_helper.rb'
require 'net/http'
require 'open-uri'
require 'fileutils'

module SaveData
  include StudentHelper
  
  TOKEN = ENV['BOT_TOKEN']
  API = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id=".freeze
  DOWNLOAD_API = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  TIME = Time.now.strftime('%a, %d %b %Y %H:%M')
  PHOTO = '/photo.jpg'
  LOCATION = '/location.txt'

  def save_photo(*)
    FileUtils.mkdir_p(path_to_save_data)
    File.open(path_to_save_data + PHOTO, 'wb') do |file|
      file << URI.open(DOWNLOAD_API + photo_path).read
    end
  end

  def save_location(*)
    File.open(path_to_save_data + LOCATION, 'wb') do |file|
      file << payload['location'].values
    end
  end

  private

  def photo_path
    JSON.parse(URI.open(API + payload['photo'].last['file_id'])
                 .read, symbolize_names: true)[:result][:file_path]
  end
end
