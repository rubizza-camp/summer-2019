module PhotoLocation
  def ask_for_photo_checkin(_context = nil, *)
    if payload.key?('photo')
      session[:photo] = payload['photo'].last['file_id']
      respond_with :message, text: 'Скинь где ты сейчас ?'
      save_context :ask_for_geo_checkin
    else
      rescue_photo_checkin
    end
  end

  def ask_for_geo_checkin(_context = nil, *)
    if payload.key?('location')
      session[:location] = payload['location']
      save
    else
      rescue_geo_checkin
    end
  end

  def rescue_photo_checkin
    save_context :ask_for_photo_checkin
    respond_with :message, text: 'Это не то, давай по новай'
  end

  def rescue_geo_checkin
    save_context :ask_for_geo_checkin
    respond_with :message, text: 'Это не геолокация'
  end

  def save
    session[:checkin_time] = Time.new
    save_check(session[:rubizza_num])
    formatted_time = session[:checkin_time].strftime '[%B-%d %I:%M %p]'
    respond_with :message, text: session[:type_of_operation] + " завершен, ремя #{formatted_time}"
  end
end
