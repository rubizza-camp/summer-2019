<<<<<<< HEAD
<<<<<<< HEAD
module CheckOut
  def check_out(dialog)
=======
class CheckOut
  def self.call(dialog)
>>>>>>> 94a9c14... working prototype without ill features
    case dialog.status
    when nil
      dialog.say_to_user('Register!')
    when 'not_registred'
      dialog.say_to_user('Register!')
<<<<<<< HEAD
    when 'registred'
      dialog.say_to_user('Send selfie!')
      dialog.change_status('check_out_photo')
=======
    when 'checked_in'
      dialog.say_to_user('Send selfie!')
      dialog.change_status('wait_out_selfie')
>>>>>>> 94a9c14... working prototype without ill features
=======
class CheckOut
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
    case user.status.to_sym
    when :checked_in
      user.save_status(:waiting_for_selfie_out)
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
>>>>>>> 8ef874f22a9a9f5675fca28d5c151f7e1f71fa75
    end
  end
end
