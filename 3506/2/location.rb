class Location
  CAMP_LOCATION = [53.915292, 27.569096].freeze

  def self.validate_in_camp(coordinates)
    distance = Haversine.distance(CAMP_LOCATION, coordinates).to_m
    'Ты не в лагере, врунишка.' if distance >= 200
  end
end
