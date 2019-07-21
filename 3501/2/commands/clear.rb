module ClearCommand
  def clear!(*)
    session[:user_sessions] = {}
  end
end
