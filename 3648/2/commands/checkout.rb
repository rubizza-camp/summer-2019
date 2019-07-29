module CheckoutCommand
  include HelpMethods
  include DownloadHelper

  def checkout!(*)
    if registred?
      save_context :get_photo_from_checkout
      respond_with :message, text: 'Отправьте фото:'
    else
      respond_with :message, text: 'Вы не вошли!'
    end
  end

  def get_photo_from_checkout(_context = nil, *)
    if photo?
      timestamp_checkout
      save_context :get_geo_from_checkout
      respond_with :message, text: 'Отправьте геолокацию:'
    else
      save_context :get_photo_from_checkout
      respond_with :message, text: 'Не похоже на фото, повторите:'
    end
  end

  def get_geo_from_checkout(_context = nil, *)
    if geo?
      download_geo(checkout_path)
      respond_with :message, text: 'Удачно отдохнуть'
    else
      save_context :get_geo_from_checkout
      respond_with :message, text: 'Не похоже на ваше местоположение, повторите:'
    end
  end
end
