class GeopositionValidator
  attr_reader :geoposition

  def initialize(geoposition)
    @geoposition = geoposition
  end

  def call
    valid_geoposition?
  end

  def self.call(geoposition:)
    new(geoposition).call
  end

  private

  CAMP_LOCATION_LATITUDE = (53.914264..53.916233).freeze
  CAMP_LOCATION_LONGITUDE = (27.565941..27.571306).freeze

  def valid_geoposition?
    raise Errors::NoGeoLocationError unless geoposition

    valid_latitude && valid_longitude
  end

  def valid_latitude
    CAMP_LOCATION_LATITUDE.cover?(geoposition['latitude'].to_f)
  end

  def valid_longitude
    CAMP_LOCATION_LONGITUDE.cover?(geoposition['longitude'].to_f)
  end
end
