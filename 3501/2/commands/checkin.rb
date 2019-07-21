module CheckinCommand
  def checkin!(*)
    session[:user_sessions][:user_sessions_controller].recieve_command(:checkin, self)
  rescue NoMethodError
    start_first
  end
end
