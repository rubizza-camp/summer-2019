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
      respond_with :message, text: 'Send self!'
    end
  end

  def check_location(*)
    if payload['location']
      check_valid_location(payload['location'].values)
    else
      save_context :check_location
      respond_with :message, text: 'Send ur location'
    end
  end

  def check_valid_location(location)
    if Haversine.distance(CAMP, location).to_km <= 0.3
      respond_with :message, text: 'Cool!'
      save_location
    else
      respond_with :message, text: 'U not in camp! Try later'
    end
  end
end
