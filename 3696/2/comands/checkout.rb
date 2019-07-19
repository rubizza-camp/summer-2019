# frozen_string_literal: true

require './helpers/base_comand_helpers'
require './helpers/validator'
module CheckoutCommand
  include BaseComandHelpers
  include Validator

  def checkout!(*)
    return if need_to_register? || need_to_checkin?

    save_context :ask_for_photo_checkout
    respond_with :message, text: 'Send me photo'
  end

  def ask_for_photo_checkout(*)
    session[:timestamp] = Time.now.getutc
    path = generate_checkout_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)
    validate_face_checkout(download_last_photo(path))
  rescue NoMethodError
    rescue_photo_checkout
  end

  def ask_for_geo_checkout(*)
    path = generate_checkout_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)
    validate_geo_checkout(path)
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
