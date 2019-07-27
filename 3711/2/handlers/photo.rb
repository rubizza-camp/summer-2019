require_relative '../downloader'
require_relative '../handlers/geo'

module PhotoHandler
  include GeoHandler
  
  def ask_photo
    respond_with :message, text: 'Send me your selfie :D'
    save_context :check_photo
  end

  def check_photo(*args)
    puts args
    if photo?
      handle_photo
      ask_geo
    else
      respond_with :message, text: "I'm waiting for a photo"
      save_context :check_photo
    end
  end

  def photo?
    payload.key?('photo')
  end

  def handle_photo
    photo_id = last_photo_data['file_id']
    return false unless photo_id

    Downloader.download_photo(photo_id, session)
  end

  def last_photo_data
    payload['photo'].last
  end
end
