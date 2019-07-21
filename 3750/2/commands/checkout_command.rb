module CheckoutCommand
  def checkout!(*)
    if checkin?
      session[:command] = 'checkout'
      save_context :photo_check
      respond_with :message, text: 'Show me yourself first'
    else
      respond_with :message, text: 'You got to checkin first'
    end
  end
end