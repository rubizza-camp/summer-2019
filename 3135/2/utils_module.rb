require 'YAML'

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

  def self.recruit_list
    YAML.load_file('recruit_list.yml')['rubizza_recruits'].map(&:to_s)
  end

  def self.registered_list
    YAML.load_file('registered_list.yml').map(&:to_s)
  end

  def self.add_to_registered_list(camp_num)
    list = YAML.load_file('registered_list.yml')
    if list
      list << camp_num.to_i
      else
      list = [camp_num.to_i]
    end
    File.open("registered_list.yml", "w") {|file| file.write(list.to_yaml)}
  end
end
