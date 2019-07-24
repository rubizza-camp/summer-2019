require_relative 'bot_response.rb'

class Status
  # :reek:all
  WAITING = 'waiting_for_registration'.freeze
  FINISH_REGISTRATION = 'end_of_registration'.freeze
  PENDING_CHECKIN_PHOTO = 'pending_checkin_photo'.freeze
  PENDING_CHECKOUT_PHOTO = 'pending_checkout_photo'.freeze
  REGISTERED = 'registered'.freeze
  PENDING_CHECKOUT_GEOLOCATION = 'pending_chekout_geolocation'.freeze
  PENDING_CHECKIN_GEOLOCATION = 'pending_checkin_geolocation'.freeze
  CHECKIN = 'checkins'.freeze
  CHECKOUT = 'checkouts'.freeze

  # :reek:all

  def developer(response, status, options)
    text = status.get_value(options[:chat_id].to_s)
    text ||= 'not_registered'
    response.message(text, options)
  end
end
