module ReceivePhotoAndLocation
  def not_registered?
    respond_with :message, text: 'C начала зарегистрируйся!!!!' unless session[:rubizza_num]
  end

  def receive_photo_from_user(*)
    if payload.key?('photo')
      session[:photo] = payload['photo'].last['file_id']
      respond_with :message, text: 'Скинь где ты сейчас ?'
      save_context :receive_geolocation_from_user
    else
      rescue_photo
    end
  end

  def receive_geolocation_from_user(*)
    if payload.key?('location')
      session[:location] = payload['location']
      save_location_and_photo
    else
      rescue_geolocation
    end
  end

  def rescue_photo
    save_context :receive_photo_from_user
    respond_with :message, text: 'Это не то, нужно фото!'
  end

  def rescue_geolocation
    save_context :receive_geolocation_from_user
    respond_with :message, text: 'Это не то, нужна геолокация!'
  end

  def save_location_and_photo
    session[:time_of_operation] = Time.new
    save_data_in_files(session[:rubizza_num])
    output_status_of_operation
  end

  def output_status_of_operation
    formatted_time = session[:time_of_operation].strftime('%I:%M%p')
    respond_with :message, text: session[:type_of_operation] + " завершен, время #{formatted_time}"
  end
end
