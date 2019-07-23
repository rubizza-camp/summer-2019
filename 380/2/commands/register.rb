module Register
  def register(dialog)
    case dialog.status
    when 'not_registred'
      sign_in(dialog)
    when 'registred'
      already_here(dialog)
    end
  end

  private

  def sign_in(dialog)
    dialog.database.set(dialog.chat_id, dialog.user_said.to_i)
    dialog.change_status('registred')
    dialog.say_to_user('You are registred! Enter /check_in for check in! :)')
  end

  def already_here(dialog)
    dialog.say_to_user('You are registred! Enter /check_in for check in! :)')
  end
end
