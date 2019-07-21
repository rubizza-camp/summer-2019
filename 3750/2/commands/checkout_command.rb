module CheckoutCommand
  def checkout!(*)
    return unless checkin?
    checkout_session_setup
    save_context :photo_check
    respond_with :message, text: 'Show me yourself first'
  end

  def checkout_session_setup
    session[:command] = 'checkout'
    session[:timestamp] = Time.now.getutc.to_i
  end
end
