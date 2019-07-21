# frozen_string_literal: true

# rubocop:disable Metrics/LineLength
require 'open-uri'
require 'json'

# :nodoc:
module DownloadHelper
  PATH_LINK = "https://api.telegram.org/bot#{ENV['TOKEN']}/getFile?file_id="
  PHOTO_LINK = "https://api.telegram.org/file/bot#{ENV['TOKEN']}/"

  def photo_file_path
    p "#{PATH_LINK}#{payload['photo'].last['file_id']}"
    JSON.parse(URI.open("https://api.telegram.org/bot#{ENV['TOKEN']}/getFile?file_id=#{payload['photo'].last['file_id']}").read)['result']['file_path']
  end

  def download_photo(dir_path)
    p photo_file_path
    File.open(dir_path + 'selfie.jpg', 'wb') do |file|
      file << URI.open("https://api.telegram.org/file/bot#{ENV['TOKEN']}/#{photo_file_path}").read
    end
  end

  def download_geo(dir_path)
    File.open(dir_path + 'geo.txt', 'wb') do |file|
      p payload
      file << payload['location'].inspect
    end
  end
end
# rubocop:enable Metrics/LineLength
