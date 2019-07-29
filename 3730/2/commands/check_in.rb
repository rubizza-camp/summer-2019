require './confirmation/path_creater'

module CheckInCommand
  include PathCreater

  def checkin!(*)
    if registred?
      enter_camp_time
      save_context :checkin_photo
      respond_with :message, text: 'Send a selfie'
    else
      respond_with :message, text: 'You did not authorize'
    end
  end

  def checkin_photo(*)
    if correct_photo?
      save_photo(checkin_dir)
      save_context :checkin_geoposition
      respond_with :message, text: 'Send your geoposition'
    else
      save_context :checkin_photo
      respond_with :message, text: 'Please send a selfie!'
    end
  end

  def checkin_geoposition(*)
    if correct_geoposition?
      save_geoposition(checkin_dir)
      respond_with :message, text: 'Check-in successful'
    else
      save_context :checkin_geoposition
      respond_with :message, text: 'Please send a geoposition!'
    end
  end
end
