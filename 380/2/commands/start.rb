module Start
  def start(dialog)
    case dialog.status
    when nil
      dialog.change_status('not_registred')
      dialog.say_to_user('Enter your number:')
    when 'not_registred'
      dialog.say_to_user('Enter your number:')
    when 'registred'
      dialog.say_to_user('You are registred! Enter /check_in for check in! :)')
    end
  end
end
