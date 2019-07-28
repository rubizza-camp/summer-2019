class AuthorizedUser
  include RedisHelper

  def initialize(save_helper)
    @save_helper = save_helper
  end

  # :reek:TooManyStatements
  def call(message)
    if !check_in? && message.text == '/check_in'
      save_session('check_ined', message)
      'Send me selfie'
    elsif check_in? && message.text == '/check_out'
      camp_id = checkout_session(message)
      save_helper.save_checkout(camp_id)
      "Great job! See you soon. Don't forget press /check_in to start work"
    else
      other_input(message)
    end
  end

  # :reek:TooManyStatements
  def other_input(message)
    if check_in? && message.photo.last
      save_photo(message)
      'Send me your location'
    elsif check_in? && message.location.latitude
      data = checkin_session(message)
      save_helper.save_checkin(data)
      'OK, have a productive work! When finish, press /check_out'
    else
      'press /check_in, send photo and then location'
    end
  end
end
