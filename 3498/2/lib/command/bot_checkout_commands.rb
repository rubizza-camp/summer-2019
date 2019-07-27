module BotCheckoutCommands
  def checkout!
    if current_user.in_camp?
      current_user.check_out
      DirManager.create_directory(current_user.camp_number, 'checkouts')
      respond_with :message, text: I18n.t(:bye)
    else
      respond_with :message, text: I18n.t(:checkout_error)
    end
  end
end
