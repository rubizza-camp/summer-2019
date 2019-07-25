require 'pry'

require_relative 'saver'

module UserPhoto
  def user_photo(*)
    if photo?
      photo_condition(payload['photo'], User[from['id']].person_number,
                      session['status'])
      save_context :geoposition
    else
      respond_with :message, text: 'Send me a photo'
      save_context :user_photo
    end
  end

  def photo?
    payload['photo']
  end

  def photo_condition(photo, person_number, folder)
    respond_with :message, text: 'Now geolocation'
    Saver::FileSaver.data_file(photo.last['file_id'], person_number, folder)
  end
end
