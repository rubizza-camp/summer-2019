# frozen_string_literal: true

require_relative 'parse_hash_exception'
require_relative 'telegram_exception'
require_relative 'base_command_helpers'
require_relative 'file_helpers'

module GeoHelpers
  include BaseCommandHelpers
  include FileHelpers

  def ask_for_geo(*)
    validate_geo(create_path(session[:command].to_s))
  rescue ParseHashException
    rescue_geo
  rescue TelegramException
    rescue_telegram
  end

  private

  def download_last_geo(path)
    File.open(path + 'geo.txt', 'wb') do |file|
      file << geo_parse.inspect
    end
  end

  def geo_parse
    location = payload.fetch('location', ParseHashException::ERR_MSG)
    raise ParseHashException if location == ParseHashException::ERR_MSG

    location
  end

  def rescue_geo
    save_context :ask_for_geo
    respond_with :message, text: 'Are you sure you sent a location?'
  end
end
