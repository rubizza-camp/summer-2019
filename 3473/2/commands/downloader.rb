# frozen_string_literal: true

require 'fileutils'
require 'down'
require 'haversine'
require './commands/util'

module Downloader
  include Util

  API = 'https://api.telegram.org/file/bot'
  CAMP = [53.9149767, 27.5690494].freeze
  FAR_AWAY = 'You are too far away. Come a little closer and try again'
  BAD_PHOTO = 'It looks like the photo didn\'t come out very well. Try again'

  def download_photo
    photo = Down.download file
    path = "./public/#{session_key}/check#{session[:check]}s/#{session[:time]}"
    FileUtils.mkdir_p(path) unless File.exist?(path)
    FileUtils.mv(photo.path, "#{path}/selfie#{File.extname(photo.original_filename)}")
  end

  def file
    file_id = payload['photo']
    raise Telegram::Bot::Error, 'Send photo!' unless file_id

    file_id = file_id.last['file_id']
    "#{API}#{token}/#{Telegram.bot.get_file(file_id: file_id)['result']['file_path']}"
  end

  def download_location
    location = payload['location']
    validate_location(location)
    path = "./public/#{session_key}/check#{session[:check]}s/#{session[:time]}"
    File.open("#{path}/geo.txt", 'w') { |file| file.puts location }
  end

  def validate_location(location)
    raise Telegram::Bot::Error, 'Send geolocation!' unless location
    raise Telegram::Bot::Error, FAR_AWAY if Haversine.distance(
      location['latitude'], location['longitude'], CAMP[0], CAMP[1]
    ).to_meters > 250
  end
end
