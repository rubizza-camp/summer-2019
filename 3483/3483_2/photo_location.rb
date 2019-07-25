require 'haversine'
require_relative 'save_data.rb'

module PhotoLocation
  include SaveData

  CAMP = [53.915205, 27.560094].freeze

  def check_data(*)
    if payload['photo']
      save_photo
      check_location
    else
      save_context :check_data
      respond_with :message, text: 'Mom sees you badly, send me a selfie.'
    end
  end

  def check_location(*)
    if payload['location']
      check_valid_location(payload['location'].values)
    else
      save_context :check_location
      respond_with :message, text: 'Are you exactly home? Send me your geoposition.'
    end
  end

  def check_valid_location(location)
    if Haversine.distance(CAMP, location).to_km <= 0.6
      respond_with :message, text: 'Love you sweetheart:3'
      save_location
    else
      respond_with :message, text: 'It seems, you are not in home. Try again.'
    end
  end
end
