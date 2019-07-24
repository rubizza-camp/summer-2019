module CheckIn
  def checkin!(*)
    error = validate_checkin
    if error
      respond_with :message, text: error
    else
      upload_checkin_photo
    end
  end

  def validate_checkin
    return 'Ты не зарегистрировался.' unless user
    return 'Ты уже в лагере.' if user.in_camp == 'true'

    nil
  end

  def checkin_upload
    @checkin_upload = UserUpload.new(:checkin, from['id'])
  end

  def upload_checkin_photo(*)
    photo = payload['photo']
    if photo
      checkin_upload.save_photo(photo.last['file_id'])
      upload_checkin_location
    else
      save_context :upload_checkin_photo
      respond_with :message, text: 'Отправь селфи.'
    end
  end

  def upload_checkin_location(*)
    if payload['location']
      coordinates = payload['location'].values
      validate_checkin_location(coordinates)
    else
      save_context :upload_checkin_location
      respond_with :message, text: 'Отправь геолокацию.'
    end
  end

  def validate_checkin_location(coordinates)
    error = Location.validate_in_camp(coordinates)
    if error
      respond_with :message, text: error
    else
      checkin_upload.save_location(coordinates)
      finalize_checkin
    end
  end

  def finalize_checkin
    checkin_upload.rename_current
    user.update(in_camp: 'true')
    respond_with :message, text: 'Хорошего дня в лагере.'
  end
end
