module CheckinCommand
  def checkin!(*)
    return respond_with :message, text: NOT_REGISTER unless redis.get(student_number)
    return respond_with :message, text: 'You must enter checkout' if session[:status] == 'checkin'
    respond_with :message, text: PHOTO
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
    session[:status] = 'checkin'
    return respond_with :message, text: SUCCESSFUL_CHECK if respond[:status]
    save_context :geo_checkin
  end
end
