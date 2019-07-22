class Selfie
  def call(dialog)
    case dialog.status
    when nil
      dialog.say_to_user('Register before send me nudes!')
    when 'not_registred'
      dialog.say_to_user('Check in, send selfie after that!')
    when 'wait_in_selfie'
      dialog.say_to_user('Send geo!')
      dialog.change_status('wait_in_geo')
    when 'wait_out_selfie'
      dialog.say_to_user('Send geo!')
      dialog.change_status('wait_out_geo')
    end
  end
end
