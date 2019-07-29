# process of selfie sending is here
class Selfie
  attr_reader :user

  def initialize(tg_id)
    @user = User.find(tg_id)
  end

  # :reek:TooManyStatements:
  def call(file_path)
    case user.status.to_sym
    when :waiting_for_selfie_in
      user.save_status(:waiting_for_geo_in) if save_img(file_path, 'check_ins')
      'Send geo for check in!'
    when :waiting_for_selfie_out
      user.save_status(:waiting_for_geo_out) if save_img(file_path, 'check_outs')
      'Send geo for exit!'
    when :checked_in then 'You already checked in! Send /check_out before send selfie again!'
    when :checked_out then 'Send /check_out before send selfie!'
    when :waiting_for_geo_in then 'Send geo for checking in'
    when :waiting_for_geo_out then 'Send geo for checking out'
    when :unregister then 'Register first!'
    end
  end

  private

  # :reek:DuplicateMethodCall, :reek:TooManyStatements
  def save_img(file_path, operation)
    save_file_path = "store/#{user.camp_id}/#{operation}/#{Time.now.getlocal('+03:00')}/"
    FileUtils.mkdir_p(save_file_path)
    image = RestClient.get(img_url(file_path)).body
    File.write(save_file_path + 'photo.jpg', image, mode: 'wb')
    Redis.current.set("user:#{user.camp_id}:folder", save_file_path)
    true
  rescue Errno::ENOENT => error
    puts error.message
  end

  # :reek:UtilityFunction:
  def img_url(file_path)
    file_path = file_path.dig('result', 'file_path')
    "https://api.telegram.org/file/bot#{ENV['TOKEN']}/#{file_path}"
  end
end
