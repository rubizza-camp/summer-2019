class CheckIn
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
    puts "check_in status: #{user.status}"
    case user.status.to_sym
    when :checked_out
      puts 'inside check_in!!!'
      user.waiting_for_selfie
      'Send selfie, please!'
    when :waiting_for_number
      'Enter your camp number!'
    when :checked_in
      'You already checked in!'
    when :waiting_for_selfie
      'Send selfie for checking in'
    when :waiting_for_geo
      'Send selfie for checking in'
    when :unregister
      'Register first!'
    end
  end
end
