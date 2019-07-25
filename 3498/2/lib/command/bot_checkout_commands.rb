module BotCheckoutCommands
  def checkout!
    if current_user.status == STATUS[0]
      current_user.status = STATUS[1]
    else
      respond_with :message, text: I18n.t(:checkout_error)
    end

    respond_with :message, text: I18n.t(:bye)
    DirManager.create_directory(current_user.camp_number, 'checkouts')
  end

  private

  def current_user
    User[session[:user_id]]
  end
end
