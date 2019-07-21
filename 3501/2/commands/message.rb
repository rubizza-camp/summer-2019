module MessageCommand
  def message(_text = nil)
    session[:user_sessions][:user_sessions_controller].recieve_command(:message, self)
  rescue NoMethodError
    start_first
  end
end
