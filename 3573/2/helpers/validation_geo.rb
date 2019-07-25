module ValidationGeo
  MINSK_CAMP_LOCATION = (53.914264..53.916233).freeze

  def valid_geo?
    raise Errors::NoGeoError unless payload['location']

    MINSK_CAMP_LOCATION.cover?(geo_parse['latitude'].to_f)
  end
end
