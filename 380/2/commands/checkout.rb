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
    end
  end
end
