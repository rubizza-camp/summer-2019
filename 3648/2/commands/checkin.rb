require_relative 'help_methods'
require_relative 'download'
require 'date'

module CheckinCommand
  include HelpMethods
  include DownloadHelper

  def checkin!(*)
    if registred?
      save_context :get_photo_from_checkin
      respond_with :message, text: 'Отправьте фото:'
    else
      respond_with :message, text: 'Вы не вошли!'
    end
  end

  def get_photo_from_checkin(_context = nil, *)
    if photo?
      timestamp_checkin
      save_context :get_geo_from_checkin
      respond_with :message, text: 'Отправьте геолокацию:'
    else
      save_context :get_photo_from_checkin
      respond_with :message, text: 'Не похоже на фото, повторите:'
    end
  end

  def get_geo_from_checkin(_context = nil, *)
    if geo?
      download_geo(checkin_path)
      respond_with :message, text: 'Удачи в кэмпе'
    else
      save_context :get_geo_from_checkin
      respond_with :message, text: 'Не похоже на ваше местоположение, повторите:'
    end
  end
end
