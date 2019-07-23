class Geo
  def self.call(dialog)
    case dialog.status
    when nil
      dialog.say_to_user('Register before send me nudes!')
    when 'not_registred'
      dialog.say_to_user('Check in, send selfie after that!')
    when 'wait_in_selfie'
      dialog.say_to_user('Send selfie before geolocation!')
    when 'wait_in_geo'
      dialog.say_to_user('You have checked in!')
      dialog.change_status('checked_in')
    when 'wait_out_geo'
      dialog.say_to_user('You have checked in!')
      dialog.change_status('registred')
    end
  end
end
