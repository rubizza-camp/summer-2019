module Photo
GET_FILE_URI = "https://api.telegram.org/bot#{ENV['TOKEN']}/getFile"
STORAGE_URI = "https://api.telegram.org/file/bot##{ENV['TOKEN']}/"

  def face_control
    respond_with :message, text: 'CMN im w8!'
    save_context :photo_from_message
  end

  def photo_from_message 
    if photo?
      downdload_photo(payload['photo'].last['file_id'])
    else
      respond_with :message, text: 'Requires a photo and nothing else!'
    end
  end

  def photo?
      payload.include?(['photo'])
  end 

  def downdload_photo
      
  end
end
