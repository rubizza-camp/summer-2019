# frozen_string_literal: true

require './helpers/base_comand_helpers'
require './helpers/validator'
module CheckinCommand
  include BaseComandHelpers
  include Validator

  def checkin!(*)
    return if need_to_register? || need_to_checkout?

    save_context :ask_for_photo_checkin
    respond_with :message, text: 'Send me photo'
  end

  def ask_for_photo_checkin(_context = nil, *)
    session[:timestamp] = Time.now.getutc
    path = generate_checkin_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)
    validate_face_checkin(download_last_photo(path))
  rescue NoMethodError
    rescue_photo_checkin
  end

  def ask_for_geo_checkin(_context = nil, *)
    path = generate_checkin_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)
    validate_geo_checkin(path)
  rescue NoMethodError
    rescue_geo_checkin
  end

  private

  def rescue_photo_checkin
    save_context :ask_for_photo_checkin
    respond_with :message, text: 'Are you sure you sent a photo?'
  end

  def rescue_geo_checkin
    save_context :ask_for_geo_checkin
    respond_with :message, text: 'Are you sure you sent a location?'
  end
end
