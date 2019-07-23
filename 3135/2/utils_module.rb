# Utils prepares data for storing
module Utils
  def self.construct_photo_uri(message, bot)
    large_file_id = message.photo.last.file_id
    file = bot.api.get_file(file_id: large_file_id)
    file_path = file.dig('result', 'file_path')
    "https://api.telegram.org/file/bot#{TOKEN}/#{file_path}"
  end

  def self.construct_location(loc)
    lat = loc.latitude.to_s
    long = loc.longitude.to_s
    "latitude: #{lat} longitude: #{long}"
  end

  def self.store_session(id, action, photo_uri, location)
    dir = "public/session_#{id}/#{action}s/#{Time.now.iso8601}"
    `mkdir -p #{dir}`
    `curl -s #{photo_uri} --output #{dir}/selfie.jpg`     
    File.open("#{dir}/geo.txt", "w") { |f| f.write(location) }
  end
end
