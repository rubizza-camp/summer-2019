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
    end
  end
end
