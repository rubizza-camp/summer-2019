module CheckoutCommand
  def checkout!(*)
    response = 'Oops, You need to register at the begin. Use command /start'
    return respond_with :message, text: response unless student_registered?(student_number)

    response = 'Send me selfie'
    respond_with :message, text: response
    save_context :checkout_photo_from_message
  end

  def checkout_photo_from_message(*)
    session['time_checkout'] = Time.now.to_s
    response = PhotoLoader.call(payload, session['time_checkout'], 'checkouts')
    respond_with :message, text: response[:message]
    return checkout! unless response[:status]

    save_context :checkout_geo_from_message if response[:status]
  end

  def checkout_geo_from_message(*)
    response = GeolocationLoader.call(payload, session['time_checkout'], 'checkouts')
    respond_with :message, text: response[:message]
    response_next = 'Thanks for the work! Have a good night!'
    return respond_with :message, text: response_next if response[:status]

    save_context :checkout_geo_from_message
  end
end
