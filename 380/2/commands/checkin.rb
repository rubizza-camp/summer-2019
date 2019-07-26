class CheckIn
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
    case user.status.to_sym
    when :checked_out
      user.save_status(:waiting_for_selfie_in)
      'Send selfie, please!'
    when :waiting_for_number
      'Enter your camp number!'
    when :checked_in
      'You already checked in!'
    when :unregister
      'Register first!'
    else
      'Finish now process! '
    end
  end
end
