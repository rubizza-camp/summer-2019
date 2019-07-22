# frozen_string_literal: true

require 'open-uri'
require 'json'

# :nodoc:
module DownloadHelper
  PATH_LINK = "https://api.telegram.org/bot#{ENV['TOKEN']}/getFile?file_id="
  PHOTO_LINK = "https://api.telegram.org/file/bot#{ENV['TOKEN']}/"

  def photo_file_path
    JSON.parse(photo_uri)['result']['file_path']
  end

  def photo_uri
    URI.open("#{PATH_LINK}#{payload['photo'].last['file_id']}").read
  end

  def download_photo(dir_path)
    File.open(dir_path + 'selfie.jpg', 'wb') do |file|
      file << URI.open("#{PHOTO_LINK}#{photo_file_path}").read
    end
  end

  def download_geo(dir_path)
    File.open(dir_path + 'geo.txt', 'wb') do |file|
      p payload
      file << payload['location'].inspect
    end
  end
end
