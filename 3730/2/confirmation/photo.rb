module Photo
  TOKEN = ENV.fetch('BOT_TOKEN')
  PATH = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id=".freeze
  PHOTO = "https://api.telegram.org/file/bot#{TOKEN}/".freeze

  def photo_path
    JSON.parse(photo_identifier)['result']['file_path']
  end

  def photo_identifier
    URI.open("#{PATH}#{payload['photo'].last['file_id']}").read
  end

  def save_photo(directory)
    File.open(directory + 'selfie.jpg', 'wb') do |file|
      file << URI.open("#{PHOTO}#{photo_path}").read
    end
  end

  def correct_photo?
    payload['photo']
  end
end
