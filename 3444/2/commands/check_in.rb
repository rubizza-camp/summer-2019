require './helpers/path_helper'

module CheckIn
  include PathHelper

  def checkin!(*)
    if registred?
      enter_camp_time
      save_context :checkin_photo
      respond_with :message, text: 'You should send me a selfie'
    else
      respond_with :message, text: 'Please, authorize before'
    end
  end

  def checkin_position(*)
    if correct_geoposition?
      save_geoposition(checkin_dir)
      respond_with :message, text: 'Check-in successful'
    else
      save_context :checkin_position
      respond_with :message, text: 'Please, send me` a geoposition!'
    end
  end

  def checkin_photo(*)
    if valid_photo?
      save_photo(checkin_dir)
      save_context :checkin_position
      respond_with :message, text: 'Please, send me your position'
    else
      save_context :checkin_photo
      respond_with :message, text: 'Please, send me a selfie!'
    end
  end
end
