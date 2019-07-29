module CheckOut
  def checkout!(*)
    error = validate_checkout
    if error
      respond_with :message, text: error
    else
      upload_checkout_photo
    end
  end

  def validate_checkout
    return 'Ты не зарегистрировался.' unless user
    return 'Ты не в лагере.' if user.in_camp == 'false'

    nil
  end

  def checkout_upload
    @checkout_upload = UserUpload.new(:checkout, from['id'])
  end

  def upload_checkout_photo(*)
    photo = payload['photo']
    if photo
      checkout_upload.save_photo(photo.last['file_id'])
      upload_checkout_location
    else
      save_context :upload_checkout_photo
      respond_with :message, text: 'Отправь селфи.'
    end
  end

  def upload_checkout_location(*)
    if payload['location']
      coordinates = payload['location'].values
      validate_checkout_location(coordinates)
    else
      save_context :upload_checkout_location
      respond_with :message, text: 'Отправь геолокацию.'
    end
  end

  def validate_checkout_location(coordinates)
    error = Location.validate_in_camp(coordinates)
    if error
      respond_with :message, text: error
    else
      checkout_upload.save_location(coordinates)
      finalize_checkout
    end
  end

  def finalize_checkout
    checkout_upload.rename_current
    user.update(in_camp: 'false')
    respond_with :message, text: 'До свидания.'
  end
end
