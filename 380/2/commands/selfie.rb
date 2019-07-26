class Selfie
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id
  end

  def call
    user = User.find(tg_id)
    case user.status
    when :waiting_for_selfie
      user.waiting_for_geo if true # selfie upload is ok?
      'Send geo, please!'
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
end
