require 'yaml'
require 'io/console'
require 'fileutils'
require_relative 'photo_downloader'

module FileManager
  API_TG_LINK = 'https://api.telegram.org/bot'.freeze
  GET_ID_LINK = '/getFile?file_id='.freeze

  include PhotoDownloader

  def save_check_file
    path = "./public/#{session[:rubizza_num]}/#{session[:check_type]}/#{session[:beginning_time]}/"
    FileUtils.mkdir_p(path)
    save_location(path)
    save_photo(path)
  end

  def save_photo(path)
    File.open(path + 'selfie.jpg', 'wb') do |file|
      file << download_photo
    end
  end

  def save_location(path)
    File.write(path + 'geo.txt', session[:location].inspect, mode: 'w')
  end

  def create_file_path; end
end
