module CheckoutCommand
  def checkout!(*)
    return unless checkin?
    session[:command] = 'checkout'
    session[:timestamp] = Time.now.getutc.to_i
    save_context :photo_check
    respond_with :message, text: 'Show me yourself first'
  end
end