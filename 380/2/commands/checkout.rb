class CheckOut
  def self.call(dialog)
    case dialog.status
    when nil
      dialog.say_to_user('Register!')
    when 'not_registred'
      dialog.say_to_user('Register!')
    when 'checked_in'
      dialog.say_to_user('Send selfie!')
      dialog.change_status('wait_out_selfie')
    end
  end
end
