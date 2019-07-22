module DataCheck
  ALLOWED_LATITUDE = 53.914260..53.916240
  ALLOWED_LONGITUDE = 27.565940..27.571310

  def photo_check(*)
    proceed_to_geo_check if photo?
    stay_in_photo_check unless photo?
  end

  def geo_check(*)
    proceed_to_command_ending if geo?
    stay_in_geo_check unless geo?
  end

  private

  def proceed_to_geo_check
    photo_save
    save_context :geo_check
    notify(:photo_check_success)
  end

  def proceed_to_command_ending
    geo_save
    checkin_ending if session[:command] == 'checkin'
    checkout_ending if session[:command] == 'checkout'
    session[:command] = nil
  end

  def stay_in_photo_check
    save_context :photo_check
    notify_with_reference(:photo_check_failure)
  end

  def stay_in_geo_check
    save_context :geo_check
    notify(:geo_check_failure)
  end

  def geo?
    return false unless payload['location']
    latitude? && longitude?
  end

  def latitude?
    ALLOWED_LATITUDE.cover? payload['location']['latitude']
  end

  def longitude?
    ALLOWED_LONGITUDE.cover? payload['location']['longitude']
  end

  def photo?
    payload['photo']
  end

  def path
    path = PathGenerator.new(session, payload).save_path
    FileUtils.mkdir_p(path) unless File.exist?(path)

    path
  end

  def photo_save
    File.open(path + 'photo.jpg', 'wb') do |file|
      file << URI.open(PathGenerator.new(session, payload).download_path).read
    end
  end

  def geo_save
    File.open(path + 'geo.txt', 'wb') do |file|
      file << payload['location'].inspect
    end
  end
end
