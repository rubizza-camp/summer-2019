class FileMethods
  API_URL = 'https://api.telegram.org/'.freeze

  def self.request_file_path(file_id, person_number, folder_name)
    uri = URI("#{API_URL}bot#{ENV['TOKEN']}/getFile?file_id=#{file_id}")
    json_response = JSON.parse(Net::HTTP.get(uri))
    new.save_photo_from_uri(json_response['result']['file_path'], person_number, folder_name)
  end

  def self.save_location_in_file(location, person_number, folder_name)
    location_path = "#{person_number}/#{folder_name}/#{Date.today}/geo"
    File.write(location_path, location, mode: 'wb')
    location_path
  end

  def save_photo_from_uri(path, person_number, folder_name)
    uri = URI("#{API_URL}file/bot#{ENV['TOKEN']}/#{path}")
    FileUtils.mkdir_p("#{person_number}/#{folder_name}/#{Date.today}")
    photo_new_path = "#{person_number}/#{folder_name}/#{Date.today}/photo.jpg"
    File.write(photo_new_path, Kernel.open(uri).read, mode: 'wb')
    photo_new_path
  end
end
