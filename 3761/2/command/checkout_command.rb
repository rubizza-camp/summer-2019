module CheckoutCommand
  def checkout!(*)
    return respond_unreg unless student_registered?(student_number)

    return respond_uncheckin unless session[:status] == 'checkin'

    respond_with :message, text: 'Send me selfie'
    save_context :checkout_photo_from_message
  end

  def checkout_photo_from_message(*)
    session[:time_checkout] = Time.now.to_s
    response = PhotoLoader.call(payload, session[:time_checkout], 'checkouts')
    respond_with :message, text: response[:message]
    return checkout! unless response[:status]

    save_context :checkout_geo_from_message if response[:status]
  end

  def checkout_geo_from_message(*)
    session[:status] = 'checkout'
    response = GeolocationLoader.call(payload, session[:time_checkout], 'checkouts')
    respond_with :message, text: response[:message]
    return respond_with :message, text: response_next if response[:status]

    save_context :checkout_geo_from_message
  end

  private

  def respond_unreg
    response_unreg = 'Oops, you need to register at the begin. Use command /start'
    respond_with :message, text: response_unreg
  end

  def respond_uncheckin
    response_uncheckin = 'Oops, you have a problem. You haven\'t already /checkin'
    respond_with :message, text: response_uncheckin
  end

  def response_next
    'Thanks for the work! Have a good night!'
  end
end
