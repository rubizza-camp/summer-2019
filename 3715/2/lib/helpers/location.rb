module Location
  MINSK_CAMP_LATITUDE = 53.913071..53.917243
  MINSK_CAMP_LONGITUDE = 27.564656..27.573243
  GEOTAG_FILE_NAME = 'geo.txt'.freeze

  def valid_location?
    payload['location'] && valid_latitude? && valid_longitude?
  end

  private

  def valid_latitude?
    MINSK_CAMP_LATITUDE.cover? payload['location']['latitude']
  end

  def valid_longitude?
    MINSK_CAMP_LONGITUDE.cover? payload['location']['longitude']
  end

  def save_location(path)
    File.open(path + GEOTAG_FILE_NAME, 'wb') do |file|
      file << payload['location']
    end
  end
end
