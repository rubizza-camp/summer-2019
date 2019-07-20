require 'yaml'
require 'io/console'
require 'fileutils'
require_relative 'photo_downloader'

module FileManager
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
end
