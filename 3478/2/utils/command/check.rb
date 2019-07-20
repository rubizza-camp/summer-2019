module Check
  def ask_for_photo_check(_context = nil, *)
    session[:beginning_time] = Time.new
    session[:photo_id] ||= payload['photo'].last['file_id']
    respond_with :message, text: '🛰 Отправте геолокацию'
    save_context :ask_for_geo_check
  rescue NoMethodError
    rescue_photo_check
  end

  def ask_for_geo_check(_context = nil, *)
    if payload.key?('location')
      session[:location] ||= payload['location']
      save_check
    else
      rescue_geo_check
    end
  end

  def rescue_photo_check
    save_context :ask_for_photo_check
    respond_with :message, text: '🚫 Это не фото'
  end

  def rescue_geo_check
    save_context :ask_for_geo_check
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
