module ValidationGeoPosition
  CAMP_LOCATION_LATITUDE = (53.914264..53.916233).freeze
  CAMP_LOCATION_LONGITUDE = (27.565941..27.571306).freeze

  def valid_geoposition?
    raise Errors::NoGeoLocationError unless payload['location']

    valid_latitude && valid_longitude
  end

  private

  def valid_latitude
    CAMP_LOCATION_LATITUDE.cover?(geolocation['latitude'].to_f)
  end

  def valid_longitude
    CAMP_LOCATION_LONGITUDE.cover?(geolocation['longitude'].to_f)
  end
end
