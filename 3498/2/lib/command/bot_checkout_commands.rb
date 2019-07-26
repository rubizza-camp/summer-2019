module BotCheckoutCommands
  def checkout!
    if current_user.in_camp?
      current_user.check_out
      respond_with :message, text: I18n.t(:bye)
      DirManager.create_directory(current_user.camp_number, 'checkouts')
    else
      respond_with :message, text: I18n.t(:checkout_error)
    end
  end
end
