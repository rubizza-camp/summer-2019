module CheckoutCommand
  def checkout!(*)
    session[:user_sessions][:user_sessions_controller].recieve_command(:checkout, self)
  rescue NoMethodError
    start_first
  end
end
