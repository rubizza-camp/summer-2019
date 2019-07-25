require 'time'
require_relative 'kids_checker'
require_relative 'photo_location.rb'

module Checkin
  include PhotoLocation
  
  def checkin!(*)
    if KidsChecker.registered(from['id']) && Gest[from['id']].in_camp == 'false'
      check_data
      Gest[from['id']].update in_camp: 'true'
    else
      respond_with :message, text: 'U in camp'
    end
  end
end
