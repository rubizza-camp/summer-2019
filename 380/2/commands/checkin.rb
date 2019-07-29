class CheckIn
  attr_reader :user

  def initialize(tg_id)
    @user = User.find(tg_id)
  end

  def call
    case user.status.to_sym
    when :checked_out
      user.save_status(:waiting_for_selfie_in)
      'Send selfie, please!'
    when :waiting_for_number then 'Enter your camp number!'
    when :checked_in then 'You already checked in!'
    when :unregister then 'Register first!'
    when nil then 'Send /start before please!'
    else 'Finish now process!'
    end
  end
end
