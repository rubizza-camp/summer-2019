module Location
  CAMP_LATITUDE = 53.914988..53.915491
  CAMP_LONGITUDE = 27.568656..27.569486

  def valid_location?
    payload['location'] && valid_latitude? && valid_longitude?
  end

  private

  def valid_latitude?
    CAMP_LATITUDE.cover? payload['location']['latitude']
  end

  def valid_longitude?
    CAMP_LONGITUDE.cover? payload['location']['longitude']
  end
end
