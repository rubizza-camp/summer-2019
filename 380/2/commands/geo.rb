class Geo
  attr_reader :bot, :user

  def initialize(tg_id, bot)
    @bot = bot
    @user = User.find(tg_id)
  end

  def call(location)
    puts 'in geo methos'
    location = "latitude: #{location.latitude} longitude: #{location.longitude}"
    case user.status.to_sym
    when :waiting_for_geo_in
      user.save_status(:checked_in)
      save_location(location, 'check_ins')
      'LETS DO IT!!!!'
    when :waiting_for_geo_out
      user.save_status(:checked_out)
      save_location(location, 'check_outs')
      'CYA!'
    when :checked_in
      'You already checked in!'
    when :checked_out
      'Send /check_in before!'
    when :waiting_for_geo
      'Send geo for checking in'
    when :unregister
      'Register first!'
    end
  end

  def save_location(location, operation)
    folder = "public/#{user.camp_id}/#{operation}/#{Time.now}/"
    FileUtils.mkdir_p(folder)
    File.write("public/#{user.camp_id}/#{operation}/#{Time.now}/location.txt", location)
  end
end
