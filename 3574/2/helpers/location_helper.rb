require 'haversine'

module LocationHelper
  CAMP_COORDINATES = [53.915205, 27.560094].freeze
  DISTANCE_ERROR = 1

  private

  def valid_location?(location)
    Haversine.distance(CAMP_COORDINATES, location).to_km <= DISTANCE_ERROR
  end
end
