# frozen_string_literal: true

require 'fileutils'
require 'open-uri'
require 'json'
require_relative 'parse_hash_exception'
require_relative 'telegram_exception'
require_relative 'base_command_helpers'
module DownloadHelpers
  include BaseCommandHelpers

  def ask_for_photo(*)
    session[:utc] = Time.now.utc
    validate_face(download_last_photo(create_path(session[:command])))
  rescue ParseHashException
    rescue_photo
  rescue TelegramException
    rescue_telegram
  end

  def ask_for_geo(*)
    validate_geo(create_path(session[:command]))
  rescue ParseHashException
    rescue_geo
  rescue TelegramException
    rescue_telegram
  end

  private

  BOT_API_URL = "https://api.telegram.org/bot#{ENV.fetch('ACCESS_BOT_TOKEN')}/"
  BOT_DOWNLOAD_API_URL = "https://api.telegram.org/file/bot#{ENV.fetch('ACCESS_BOT_TOKEN')}/"
  GET_PATH_URL = 'getFile?file_id='

  def download_last_photo(path)
    telegram_path = photo_file_path
    File.open(path + 'selfie.jpg', 'wb') do |file|
      file << URI.open(BOT_DOWNLOAD_API_URL + telegram_path).read
    end
  end

  def download_last_geo(path)
    File.open(path + 'geo.txt', 'wb') do |file|
      file << geo_parse.inspect
    end
  end

  def generate_path(name)
    "./public/#{user_id}/#{name}s/#{session[:utc]}/"
  end

  def photo_file_path
    path = JSON.parse(URI.open(create_path_request_url).read, symbolize_names: true)
               .fetch(:result, {}).fetch(:file_path, TelegramException::ERR_MSG)
    raise TelegramException if path == TelegramException::ERR_MSG

    path
  end

  def create_path_request_url
    BOT_API_URL + GET_PATH_URL + photo_id
  end

  def create_path(name)
    path = generate_path(name)
    FileUtils.mkdir_p(path) unless File.exist?(path)
    path
  end

  def geo_parse
    location = payload.fetch('location', ParseHashException::ERR_MSG)
    raise ParseHashException if location == ParseHashException::ERR_MSG

    location
  end

  def photo_id
    id = payload.fetch('photo', [{}]).last.fetch('file_id', ParseHashException::ERR_MSG)
    raise ParseHashException if id == ParseHashException::ERR_MSG

    id
  end

  def rescue_photo
    save_context :ask_for_photo
    respond_with :message, text: 'Are you sure you sent a photo?'
  end

  def rescue_geo
    save_context :ask_for_geo
    respond_with :message, text: 'Are you sure you sent a location?'
  end
end
