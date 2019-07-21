module CheckinCommand
  def checkin!(*)
    return unless registered?
    return unless checkout?
    checkin_session_setup
    save_context :photo_check
    respond_with :message, text: 'Show me yourself first'
  end

  private

  def checkin_session_setup
    session[:command] = 'checkin'
    session[:timestamp] = Time.now.getutc.to_i
  end
end
