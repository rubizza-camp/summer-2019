require 'haversine'

# module that check distance between u and camp
module LocationHelper
  CAMP = [53.915205, 27.560094].freeze

  def valid_location(location)
    Haversine.distance(CAMP, location).to_km <= 2.0
  end
end
