require_relative 'helpers/session_state'
require_relative 'helpers/location'
require_relative 'helpers/photo'
require_relative 'helpers/save'

module CheckoutCommand
  include SessionState
  include Location
  include Photo
  include Save

  def checkout!(*)
    return unless allready_registered
    return unless allready_checkined

    save_context :checkout_photo
    respond_with :message, text: 'Пришли мне своё фото.'
  end

  def checkout_photo(*)
    if payload['photo']
      session[:path_to_photo] = path_to_photo(payload['photo'].last['file_id'])
      save_context :checkout_location
      respond_with :message, text: 'Красава! Теперь пришли мне свои координаты.'
    else
      save_context :checkout_photo
      respond_with :message, text: 'Ты прислал что-то не то. Попробуй ещё раз.'
    end
  end

  def checkout_location(*)
    if valid_location?
      save_data(:checkout)
      respond_with :message, text: 'Отдохни хорошенько и приходи снова -> /checkin'
    else
      save_context :checkout_location
      respond_with :message, text: 'Подойди поближе.'
    end
  end
end
