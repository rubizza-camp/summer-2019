module CheckinCommand
  def checkin!(*)
    return respond_with :message, text: 'You are not registered' unless redis.get(student_number)
    return respond_with :message, text: 'You must enter checkout' if session[:status] == 'checkin'
    session[:status] = 'checkin'
    respond_with :message, text: 'Send photo'
    save_context :photo_checkin
  end

  def photo_checkin(*)
    session[:time_checkin] = Time.now.to_i
    respond = LoaderPhoto.call(payload, session['time_checkin'], 'checkin')
    respond_with :message, text: respond[:message]
    return checkin! unless respond[:status]
    save_context :geo_checkin if respond[:status]
  end

  def geo_checkin(*)
    respond = LoaderGeoLocation.call(payload, session['time_checkin'], 'checkin')
    respond_with :message, text: respond[:message]
    return respond_with :message, text: 'Have a good day!' if respond[:status]
    save_context :geo_checkin
  end
end
