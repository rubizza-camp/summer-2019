# rubocop:disable all
class AuthorizedUser
  include RedisHelper

  def initialize(save_helper)
    @save_helper = save_helper
  end

  def call(message)
    if check_in?(message)
      save_session("check_ined", message)
      "Send me selfie"
    elsif check_out?(message)
      camp_id = checkout_session(message)
      save_helper.save_checkout(camp_id)
      "Great job! See you soon. Don't forget press /check_in to start work"
    elsif send_photo?(message)
      save_photo(message)
      "Send me your location"
    elsif send_location?(message)
      data = checkin_session(message)
      save_helper.save_checkin(data)
      "OK, have a productive work! When finish, press /check_out"
    else
      "press /check_in, send photo and then location"
    end
  end
end
