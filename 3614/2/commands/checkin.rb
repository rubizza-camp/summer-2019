require './reg'
require './handlers/photo_handler'
require './handlers/geo_handler'


module CheckIn
  include Photo
  # include GeoLocation
  def checkin!(*)
    if registr?
      if checkin?
        respond_with :message, text: 'U already in :)'
      else
        checkin
      end
    else
      registration
    end

  end

  def checkin?
    session[:check] == :yep
    
  end

  def checkin
    respond_with :message, text: 'Require your pretty face pls :)'
    face_control
    # geo_control
  end
end
