module CheckPhoto
  def receive_photo(*)
    if payload['photo']
      save_photo_on_disk
      say_to_user_chat('photo success, send location')
      save_context(:geo_check)
    else
      say_to_user_chat('photo error, give me photo!')
      save_context(:receive_photo)
    end
  end

  private

  def save_photo_on_disk
    File.open(photo_session_path + 'photo.jpg', 'wb') do |file|
      file << URI.open(PathCreator.download_path(session, payload, TOKEN).to_s).read
    end
  end

  def photo_session_path
    path = PathCreator.save_path(session, payload, TOKEN)
    FileUtils.mkdir_p(path) unless File.exist?(path)
    path
  end
end
