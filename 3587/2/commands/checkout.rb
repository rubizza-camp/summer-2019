module CheckoutCommand
  def checkout!(*)
    return respond_with :message, text: NOT_REGISTER unless redis.get(student_number)
    return respond_with :message, text: 'Enter checkin first' unless session[:status] == 'checkin'
    respond_with :message, text: PHOTO
    save_context :photo_checkout
  end

  def photo_checkout(*)
    session[:time_checkout] = Time.now.to_i
    respond = LoaderPhoto.call(payload, session['time_checkout'], 'checkout')
    respond_with :message, text: respond[:message]
    return checkout! unless respond[:status]

    save_context :geo_checkout if respond[:status]
  end

  def geo_checkout(*)
    respond = LoaderGeoLocation.call(payload, session['time_checkout'], 'checkout')
    respond_with :message, text: respond[:message]
    session[:status] = 'checkout'
    return respond_with :message, text: work_time if respond[:status]
    save_context :geo_checkout
  end

  def work_time
    work_time = session[:time_checkout] - session[:time_checkin]
    work_time_string = Time.at(work_time).utc.strftime('%H hours, %M  minutes')
    "See u next time! Your work time #{work_time_string}"
  end
end
