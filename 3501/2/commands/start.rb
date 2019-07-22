module StartCommand
  def start!(*)
    session[:user_sessions] = {} unless session[:user_sessions]
    session[:user_sessions][:user_sessions_controller] =
      UserSessionsController.new(session[:user_sessions], TOKEN, self)
  end
end
