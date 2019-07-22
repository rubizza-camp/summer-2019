# frozen_string_literal: true

require 'fileutils'
require 'down'
require 'haversine'
require_relative './util'
require_relative './validator'

module Downloader
  include Util
  include Validator

  API = 'https://api.telegram.org/file/bot'

  def download_photo
    photo = Down.download file_path
    # validate(photo)
    path = "./public/#{session_key}/check#{session[:check]}s/#{session[:time]}"
    FileUtils.mkdir_p(path) unless File.exist?(path)
    FileUtils.mv(photo.path, "#{path}/selfie#{File.extname(photo.original_filename)}")
  end

  def file_path
    file_id = payload['photo'].to_a.last['file_id']
    raise Telegram::Bot::Error, 'Send photo!' unless file_id

    "#{API}#{token}/#{Telegram.bot.get_file(file_id: file_id).to_h['result'].to_h['file_path']}"
  end

  def download_location
    location = payload['location']
    validate_location(location)
    path = "./public/#{session_key}/check#{session[:check]}s/#{session[:time]}"
    File.open("#{path}/geo.txt", 'w') { |file| file.puts location }
  end
end
