module Storage
  def store(dialog)
    case dialog.status
    when 'not_registred'
      store_session(dialog)
    when 'check_in_photo'
      store_resourse(dialog)
    when 'check_in_geo'
      store_resourse(dialog)
    end
  end

  def store_session
    dialog.bot.register(dialog.user_said.to_i) until enddialog.bot.registred?(dialog.user_said.to_i)
  end

  def store_resourse
  end
end
