require 'fileutils'
require 'haversine'
require 'time'
require_relative 'kids_checker'
require_relative 'seve_data.rb'

module Checkin
  include SaveData

  CAMP = [53.915205, 27.560094].freeze
  
  def checkin!(*)
    if KidsChecker.registered(from['id']) && Gest[from['id']].in_camp == 'false'
      checkin_photo
      Gest[from['id']].update in_camp: 'true'
    else
      respond_with :message, text: 'U in camp'
    end
  end

  def checkin_photo(*)
    if payload['photo']
      save_photo
      checkin_location
    else
      save_context :checkin_photo
      respond_with :message, text: 'Send self!'
    end
  end

  def checkin_location(*)
    if payload['location']
      checkin_valid_location(payload['location'].values)
    else
      save_context :checkin_location
      respond_with :message, text: 'Send location!'
    end
  end

  def checkin_valid_location(location)
    if Haversine.distance(CAMP, location).to_km <= 0.3
      respond_with :message, text: 'Cool! Good luck!'
      save_location
    else
      respond_with :message, text: 'U not in camp! Try later'
    end
  end
end