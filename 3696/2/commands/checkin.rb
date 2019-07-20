# frozen_string_literal: true

require './helpers/base_command_helpers'
require './helpers/validator'

module CheckinCommand
  include BaseCommandHelpers
  include Validator

  def checkin!(*)
    return if need_to_register? || need_to_checkout?

    save_context :ask_for_photo_checkin
    respond_with :message, text: 'Send me photo'
  end

  def ask_for_photo_checkin(*)
    session[:timestamp] = Time.now.to_i
    validate_face_checkin(download_last_photo(create_checkin_path))
  rescue NoMethodError
    rescue_photo_checkin
  end

  def ask_for_geo_checkin(*)
    validate_geo_checkin(create_checkin_path)
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
