require 'fileutils'

# process of geo sending is here
class Geo
  attr_reader :user

  def initialize(tg_id)
    @user = User.find(tg_id)
  end

  # :reek:TooManyStatements:
  def call(location)
    result = "latitude: #{location.latitude} longitude: #{location.longitude}"
    case user.status.to_sym
    when :waiting_for_geo_in
      user.save_status(:checked_in) if save_location(result, 'check_ins')
      'LETS DO IT!!!!'
    when :waiting_for_geo_out
      user.save_status(:checked_out) if save_location(result, 'check_outs')
      'CYA!'
    when :checked_in then 'You already checked in!'
    when :checked_out then 'Send /check_in before!'
    when :waiting_for_geo then 'Send geo for checking in'
    when :unregister then 'Register first!'
    end
  end

  def save_location(location)
    save_file_path = Redis.current.get("user:#{user.camp_id}:folder")
    File.write(save_file_path + 'geo.txt', location)
  end
end
