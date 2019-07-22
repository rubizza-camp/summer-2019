# frozen_string_literal: true

module Validator
  CAMP = [53.9149767, 27.5690494].freeze
  CAMP_RADIUS = 250
  FAR_AWAY = 'You are too far away. Come a little closer and try again'
  BAD_PHOTO = 'It looks like the photo didn\'t come out very well. Try again'

  def validate_location(location)
    raise Telegram::Bot::Error, 'Send geolocation!' unless location
    raise Telegram::Bot::Error, FAR_AWAY if Haversine.distance(
      location['latitude'], location['longitude'], CAMP[0], CAMP[1]
    ).to_meters > CAMP_RADIUS
  end
end
