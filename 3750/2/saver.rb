require_relative 'path_generator'

module Saver
  include PathGenerator

  def path
    path = save_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)

    path
  end

  def photo_save
    File.open(path + 'photo.jpg', 'wb') do |file|
      file << URI.open(download_path).read
    end
  end

  def geo_save
    File.open(path + 'geo.txt', 'wb') do |file|
      file << payload['location'].inspect
    end
  end
end
