require_relative '../helpers/location_helper'
require_relative '../helpers/photo_helper'
require_relative '../helpers/save_helper'

module CheckoutCommand
  def allready_registered
    respond_with :message, text: 'Сначала регистрация ~> /start' unless session.key?(:number)
    session.key?(:number)
  end

  def allready_checkined
    respond_with :message, text: 'Прими смену ~> /checkin' unless session[:checkin]
    session[:checkin]
  end

  def checkout!(*)
    return unless allready_registered
    return unless allready_checkined
    save_context :checkout_photo
    respond_with :message, text: 'Пришли мне себя.'
  end

  def checkout_photo(*)
    if payload['photo']
      session[:path_to_photo] = path_to_photo(payload['photo'].last['file_id'])
      save_context :checkout_location
      respond_with :message, text: 'Теперь пришли мне координаты.'
    else
      save_context :checkout_photo
      respond_with :message, text: 'Ты прислал что-то не то. Попробуй ещё раз.'
    end
  end

  def checkout_location(*)
    if payload['location'] && valid_location?(payload['location'].values)
      save_data(:checkout)
      session[:checkout] = !session[:checkout]
      respond_with :message, text: 'Жду тебя снова ~> /checkin'
    else
      save_context :checkout_location
      respond_with :message, text: 'Ты не в кемпе.'
    end
  end
end
