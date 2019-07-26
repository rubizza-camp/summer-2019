module StartCommand
  def start!
    return respond_with :message, text: I18n.t(:already_registered) if member_is_registered?

    save_context :number_validation_for_registration
    respond_with :message, text: I18n.t(:start)
  end

  def number_validation_for_registration(answer = '')
    respond_text = if member_exist?(answer)
                     login(REDIS, answer)
                   else
                     I18n.t(:mismatch_error)
                   end
    respond_with :message, text: respond_text
  end

  private

  def login(redis, number)
    session[:number] = number
    redis.set(number, from['id'])
    checkin
    I18n.t(:successful_registration)
  end
end
