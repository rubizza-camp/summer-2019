module StartCommand
  def start!
    return respond_with :message, text: ALREADY_REGISTERED_MESSAGE if member_is_registered?

    save_context :number_validation_for_registration
    respond_with :message, text: START_MESSAGE
  end

  def number_validation_for_registration(answer = '')
    respond_text = if member_exist?(answer)
                     login(REDIS, answer)
                   else
                     MISMATCH_ERROR_MESSAGE
                   end
    respond_with :message, text: respond_text
  end

  private

  def login(redis, number)
    session[:number] = number
    redis.set(number, from['id'])
    checkin
    SUCCESSFUL_REGISTRATION_MESSAGE
  end
end
