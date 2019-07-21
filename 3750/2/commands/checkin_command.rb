module CheckinCommand
  def checkin!(*)
    return unless no_command_conflict?
    checkin_session_setup
    save_context :photo_check
    respond_with :message, text: 'Show me yourself first'
  end

  private

  def checkin_session_setup
    session[:command] = 'checkin'
    session[:timestamp] = Time.now.getutc.to_i
  end

  def no_command_conflict?
    if !registered?
      respond_with :message, text: "You got to register first.
      This will be easy, just type in /start command and I'll check your number in list"
      return false
    elsif !checkout?
      respond_with :message, text: 'You need to /checkout from current shift
      before you can /checkin in a new one'
      return false
    end
    true
  end
end
