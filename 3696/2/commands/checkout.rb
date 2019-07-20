# frozen_string_literal: true

require './helpers/base_command_helpers'
require './helpers/validator'

module CheckoutCommand
  include BaseCommandHelpers
  include Validator

  def checkout!(*)
    return if need_to_register? || need_to_checkin?

    save_context :ask_for_photo_checkout
    respond_with :message, text: 'Send me photo'
  end

  def ask_for_photo_checkout(*)
    session[:timestamp] = Time.now.to_i
    validate_face_checkout(download_last_photo(create_checkout_path))
  rescue NoMethodError
    rescue_photo_checkout
  end

  def ask_for_geo_checkout(*)
    validate_geo_checkout(create_checkout_path)
  rescue NoMethodError
    rescue_geo_checkout
  end

  private

  def rescue_photo_checkout
    save_context :ask_for_photo_checkout
    respond_with :message, text: 'Are you sure you sent a photo?'
  end

  def rescue_geo_checkout
    save_context :ask_for_geo_checkout
    respond_with :message, text: 'Are you sure you sent a location?'
  end
end
