module GeoValidator
  ALLOWED_LATITUDE = 53.914260..53.916240
  ALLOWED_LONGITUDE = 27.565940..27.571310

  def geo?
    return false unless payload['location']
    latitude? && longitude?
  end

  private

  def latitude?
    ALLOWED_LATITUDE.cover? payload['location']['latitude']
  end

  def longitude?
    ALLOWED_LONGITUDE.cover? payload['location']['longitude']
  end
end
