module CheckinCommand
  def checkin!(*)
    return unless registered?
    session[:command] = 'checkin'
    save_context :photo_check
    respond_with :message, text: 'Show me yourself first'
  end
end