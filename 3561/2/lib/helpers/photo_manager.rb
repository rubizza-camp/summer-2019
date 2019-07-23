# frozen_string_literal: true

class PhotoManager
  API_URL = 'https://api.telegram.org/'

  def request_file_path(file_id, photo_new_path)
    uri = URI("#{API_URL}bot#{ENV['TOKEN']}/getFile?file_id=#{file_id}")
    json_response = JSON.parse(Net::HTTP.get(uri))
    load_file_from_path(json_response['result']['file_path'], photo_new_path)
  end

  private

  def load_file_from_path(file_path, photo_new_path)
    uri = URI("#{API_URL}file/bot#{ENV['TOKEN']}/#{file_path}")
    File.write(safe_photo_in_directory(photo_new_path), URI.open(uri).read, mode: 'wb')
  end

  def safe_photo_in_directory(photo_new_path)
    DirectoryManager.create_directory(photo_new_path)
    "#{photo_new_path}selfie.jpg"
  end
end
