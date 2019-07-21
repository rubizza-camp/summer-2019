module CheckinCommand
  def checkin!(*)
    return unless registered?
    return unless checkout?
    session[:command] = 'checkin'
    session[:timestamp] = Time.now.getutc.to_i
    save_context :photo_check
    respond_with :message, text: 'Show me yourself first'
  end
end