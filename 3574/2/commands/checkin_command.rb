require_relative '../helpers/location_helper'
require_relative '../helpers/photo_helper'
require_relative '../helpers/save_helper'

module CheckinCommand
  def checkin!(*)
    return unless allready_registered do
      respond_with :message, text: 'Сначала регистрация ~> /start' unless session.key?(:number)
      session.key?(:number)
    end
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
    if payload['location'] && valid_location?(payload['location'].values)
      save_data(:checkin)
      session[:checkin] = !session[:checkin]
      respond_with :message, text: 'Удачной работы! Сдать смену можешь так ~> /checkout'
    else
      save_context :checkin_location
      respond_with :message, text: 'Ты не в кемпе.'
    end
  end
end
