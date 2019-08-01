require 'haversine'
require_relative 'save_data.rb'

module PhotoLocation
  include SaveData

  CAMP_LOCATION = [53.915205, 27.560094].freeze
  MAX_RADIUS = 1

  def check_data(*)
    if payload['photo']
      save_photo
      check_location
    else
      save_context :check_data
      respond_with :message, text: t(:selfie)
    end
  end

  def check_location(*)
    if payload['location']
      check_valid_location(payload['location'].values)
    else
      save_context :check_location
      respond_with :message, text: t(:geo)
    end
  end

  def check_valid_location(location)
    if Haversine.distance(CAMP_LOCATION, location).to_km <= MAX_RADIUS
      respond_with :message, text: t(:done)
      save_location
    else
      respond_with :message, text: t(:geo_error)
    end
  end
end
