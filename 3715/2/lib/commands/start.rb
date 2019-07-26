module StartCommand
  def start!
    return if registered

    save_context :validation
    respond_with :message, text: START_MESSAGE
  end

  def validation(answer = '')
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
    session[:state] = 'checkin'
    SUCCESSFUL_REGISTRATION_MESSAGE
  end
end
