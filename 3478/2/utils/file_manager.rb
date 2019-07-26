require 'yaml'
require 'io/console'
require 'fileutils'
require 'open-uri'
require 'json'

module FileManager
  API_TG_LINK = 'https://api.telegram.org/bot'.freeze
  GET_ID_LINK = '/getFile?file_id='.freeze

  def pre_generate_folder
    FileUtils.mkdir_p(user_folder_path)
  end

  def download_photo
    file_path = JSON.parse(URI.open(create_file_path).read)['result']['file_path']
    URI.open(create_photo_path(file_path)).read
  end


  def save_check_file
    path_to_save_folder = save_path
    FileUtils.mkdir_p(path_to_save_folder)
    save_location(path_to_save_folder)
    save_photo(path_to_save_folder)
  end

  private

  def save_photo(path)
    File.open(path + 'selfie.jpg', 'wb') do |file|
      file << download_photo
    end
  end

  def save_location(path)
    File.write(path + 'geo.txt', session[:location].inspect, mode: 'w')
  end

  def save_path
    "./public/#{session[:rubizza_num]}/#{session[:check_type]}/#{session[:beginning_time]}/"
  end

  def user_folder_path
    "/public/#{session[:rubizza_num]}/#{session[:check_type]}"
  end

  def create_file_path
    API_TG_LINK + ENV['TELEGRAM_TOKEN'] + GET_ID_LINK + session[:photo_id]
  end

  def create_photo_path(file_path)
    "https://api.telegram.org/file/bot#{ENV['TELEGRAM_TOKEN']}/#{file_path}"
  end
end
