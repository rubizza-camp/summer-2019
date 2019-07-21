module LogoutCommand
  def logout!
    if registered?
      respond_with :message, text: "Goodbye, #{session[:number]}!"
      session.destroy
    else
      respond_with :message, text: 'Nice try!'
    end
  end
end
