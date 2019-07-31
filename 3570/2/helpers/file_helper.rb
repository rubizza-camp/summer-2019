# frozen_string_literal: true

module FileHelper
  LATITUDE = (53.915062..53.916196).freeze
  LONGITUDE = (27.570512..27.571472).freeze
  PATH = 'https://api.telegram.org/bot'
  FILE_PATH = 'https://api.telegram.org/file/bot'

  def photo_id
    payload['photo'].last['file_id']
  end

  def download_photo
    token = ENV['TOKEN']
    file_path = URI.open("#{PATH}#{token}/getFile?file_id=#{photo_id}").read
    link = JSON.parse(file_path)['result']['file_path']
    URI.open("#{FILE_PATH}#{token}/#{link}").read
  end

  def save_photo(directory)
    File.open(directory + 'photo.jpg', 'wb') do |file|
      file << download_photo
    end
  end

  def location
    payload['location'].inspect
  end

  def latitude
    payload['location']['latitude']
  end

  def longitude
    payload['location']['longiture']
  end

  def save_location(directory)
    File.open(directory + 'geo.txt', 'wb') do |file|
      file << location
    end
  end

  def validate_location
    LATITUDE.cover?(latitude) && LONGITUDE.cover?(longitude)
  end
end
