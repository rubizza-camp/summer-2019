module CheckOut
  def check_out(dialog)
    case dialog.status
    when nil
      dialog.say_to_user('Register!')
    when 'not_registred'
      dialog.say_to_user('Register!')
    when 'registred'
      dialog.say_to_user('Send selfie!')
      dialog.change_status('check_out_photo')
    end
  end
end
