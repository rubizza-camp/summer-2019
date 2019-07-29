require 'haversine'

# module that check distance between your current location and camp
class LocationHelper
  CAMP_COORDINATES = [53.915205, 27.560094].freeze
  DISTANCE_ERROR = 0.5

  def self.valid_location(location)
    Haversine.distance(CAMP_COORDINATES, location).to_km <= DISTANCE_ERROR
  end
end
