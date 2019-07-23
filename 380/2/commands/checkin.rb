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
class CheckIn
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
    if user
      user.check_in
    else
      u = User.new(tg_id)
      u.check_in
      'Send selfie, please!'
>>>>>>> 94a9c14... working prototype without ill features
    end
  end
end
