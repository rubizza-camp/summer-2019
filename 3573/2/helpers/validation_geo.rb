module ValidationGeoPosition
  MINSK_CAMP_LOCATION = (53.914264..53.916233).freeze

  def valid_geoposition?
    raise Errors::NoGeoLocationError unless payload['location']

    MINSK_CAMP_LOCATION.cover?(geolocation['latitude'].to_f)
  end
end
