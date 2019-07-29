# process of checking out starts here
class CheckOut
  attr_reader :user

  def initialize(tg_id)
    @user = User.find(tg_id)
  end

  # :reek:TooManyStatements:
  # rubocop:disable Metrics/CyclomaticComplexity
  def call
    case user.status.to_sym
    when :checked_in
      user.save_status(:waiting_for_selfie_out)
      'Send selfie, please!'
    when :waiting_for_number then 'Enter your camp number!'
    when :checked_out then 'You already checked out!'
    when :waiting_for_selfie then 'Send selfie for check in'
    when :waiting_for_geo then 'Send selfie for checki in'
    when :unregister then 'Register first!'
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end
