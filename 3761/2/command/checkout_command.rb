module CheckoutCommand
  def checkout!(*)
    return respond_unregester unless student_registered?(student_number)

    return respond_uncheckin unless session[:status] == :checkin

    respond_ask_photo
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
    session[:status] = :checkout
    response = GeolocationLoader.call(payload, session[:time_checkout], 'checkouts')
    respond_with :message, text: response[:message]
    return respond_checkout_end if response[:status]

    save_context :checkout_geo_from_message
  end
end
