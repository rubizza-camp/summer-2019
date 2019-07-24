# rubocop:disable all
class User
  include RedisHelper

  def call(message)
    if started?(message)
      "Hello. Enter your id"
    elsif entered?(message)
      save_session("camp_id", message)
      "you entered, press /checkin"
    else
      "Enter right id"
    end
  end
end
