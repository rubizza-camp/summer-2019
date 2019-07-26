require 'open-uri'

class Selfie
  attr_reader :bot, :user

  def initialize(tg_id, bot)
    @bot = bot
    @user = User.find(tg_id)
  end

  def call(file_id)
    case user.status.to_sym
    when :waiting_for_selfie_in
      user.save_status(:waiting_for_geo_in) if save_img(file_id, 'check_ins')
      'Send geo for check in!'
    when :waiting_for_selfie_out
      user.save_status(:waiting_for_geo_out) if save_img(file_id, 'check_outs')
      'Send geo for exit!'
    when :checked_in
      'You already checked in! Send /check_out before send selfie again!'
    when :checked_out
      'Send /check_out before send selfie!'
    when :waiting_for_geo_in
      'Send geo for checking in'
    when :waiting_for_geo_out
      'Send geo for checking out'
    when :unregister
      'Register first!'
    end
  end

  def img_url(file_id)
    file_path = bot.api.get_file(file_id: file_id).dig('result', 'file_path')
    "https://api.telegram.org/file/bot#{ENV['TOKEN']}/#{file_path}"
  end

  def save_img(file_id, operation)
    file_path = "public/#{user.camp_id}/#{operation}/#{Time.now}/"
    FileUtils.mkdir_p(file_path)
    open(img_url(file_id)) do |image|
      File.open(file_path + 'photo.jpg', 'wb') do |file|
        file.write(image.read)
      end
    end
    true
  rescue Errno::ENOENT => e
    puts e.message
  end
end
