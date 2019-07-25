module BotCheckinCommands
  def checkin!(*)
    if current_user.status == 'in'
      respond_with :message, text: I18n.t(:checkin_error)
    else
      save_context :manage_selfie
      current_user.status = 'in'
      respond_with :message, text: I18n.t(:selfie_request)
    end
  end

  def current_user
    User[session[:user_id]]
  end

  def manage_selfie
    photo_id = payload['photo'].last['file_id']
    PhotoUploader.upload_selfie(current_user.camp_number, photo_id)
    respond_with :message, text: I18n.t(:location_request)
    save_context :upload_location
  end

  def upload_location
    latitude = payload['location']['latitude']
    longitude = payload['location']['longitude']
    GeolocationUploader.create_location_file(current_user.camp_number, latitude, longitude)
    respond_with :message, text: I18n.t(:checkin_success)
  end
end
