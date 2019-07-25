module UserInputHandler
  def ask_for_photo(_context = nil, *)
    session[:beginning_time] = Time.now.to_i
    session[:photo_id] = payload['photo'].last['file_id']
    respond_with :message, text: '🛰 Отправте геолокацию'
    save_context :ask_for_geo
  rescue NoMethodError
    no_photo_provided
  end

  def ask_for_geo(_context = nil, *)
    if payload.key?('location')
      session[:location] = payload['location']
      save_check
    else
      no_geo_provided
    end
  end

  private

  def no_photo_provided
    save_context :ask_for_photo
    respond_with :message, text: '🚫 Это не фото'
  end

  def no_geo_provided
    save_context :ask_for_geo
    respond_with :message, text: '🚫 Это не геолокация'
  end

  def save_check
    save_check_file
    session[:location] = nil
    session[:photo_id] = nil
    formatted_time = session[:beginning_time].strftime '[%B-%d %I:%M %p]'
    respond_with :message, text: "🕑 #{session[:check_type]}  #{formatted_time}"
  end
end
