<<<<<<< HEAD
<<<<<<< HEAD
module CheckIn
  def check_in(dialog)
    case dialog.status
    when nil
      dialog.say_to_user('Register before come here!')
    when 'not_registred'
      dialog.say_to_user('Register!')
    when 'registred'
      dialog.say_to_user('Send selfie!')
      dialog.change_status('check_in_photo')
=======
=======
>>>>>>> 8ef874f22a9a9f5675fca28d5c151f7e1f71fa75
class CheckIn
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
<<<<<<< HEAD
    if user
      user.check_in
    else
      u = User.new(tg_id)
      u.check_in
      'Send selfie, please!'
>>>>>>> 94a9c14... working prototype without ill features
=======
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
      'Finish now process!'
>>>>>>> 8ef874f22a9a9f5675fca28d5c151f7e1f71fa75
    end
  end
end
