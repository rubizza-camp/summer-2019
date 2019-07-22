require_relative 'validators/geo_validator'
require_relative 'validators/photo_validator'
require_relative 'saver'

module DataCheck
  include GeoValidator
  include PhotoValidator
  include Saver

  MSG = {
    photo_check_success: 'Good. Now i need your geolocation',
    photo_check_failure: "I don't see a photo here",
    geo_check_failure: "I don't see you in place"
  }.freeze

  def photo_check(*)
    if photo?
      proceed_to_geo_check
      notify(MSG[:photo_check_success])
    else
      stay_in_photo_check
      notify_with_reference(MSG[:photo_check_failure])
    end
  end

  def geo_check(*)
    if geo?
      proceed_to_command_ending
    else
      stay_in_geo_check
      notify([:geo_check_failure])
    end
  end

  private

  def proceed_to_geo_check
    photo_save
    save_context :geo_check
  end

  def proceed_to_command_ending
    geo_save
    checkin_ending if session[:command] == 'checkin'
    checkout_ending if session[:command] == 'checkout'
    session[:command] = nil
  end

  def stay_in_photo_check
    save_context :photo_check
  end

  def stay_in_geo_check
    save_context :geo_check
  end
end
