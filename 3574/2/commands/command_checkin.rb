require_relative '../helpers/session_state'
require_relative '../helpers/location'
require_relative '../helpers/photo'
require_relative '../helpers/save'

module CheckinCommand
  include SessionStatus
  include Location
  include Photo
  include Save

  def checkin!(*)
    return unless allready_registered
    return unless allready_checkouted

    save_context :checkin_photo
    respond_with :message, text: 'Пришли мне себя.'
  end

  def checkin_photo(*)
    if payload['photo']
      session[:path_to_photo] = path_to_photo(payload['photo'].last['file_id'])
      save_context :checkin_location
      respond_with :message, text: 'Теперь пришли мне координаты.'
    else
      save_context :checkin_photo
      respond_with :message, text: 'Ты прислал что-то не то. Попробуй ещё раз.'
    end
  end

  def checkin_location(*)
    if valid_location?
      save_data(:checkin)
      respond_with :message, text: 'Удачной работы! Сдать смену можешь так ~> /checkout'
    else
      save_context :checkin_location
      respond_with :message, text: 'Ты не в кемпе.'
    end
  end
end
