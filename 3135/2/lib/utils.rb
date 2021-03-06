require 'yaml'

# Utils prepares data for storing
module Utils
  def self.construct_photo_uri(file_id_list, bot)
    large_file_id = file_id_list.last.file_id
    file = bot.api.get_file(file_id: large_file_id)
    file_path = file.dig('result', 'file_path')
    "https://api.telegram.org/file/bot#{TOKEN}/#{file_path}"
  end

  def self.construct_location(loc)
    lat = loc.latitude.to_s
    long = loc.longitude.to_s
    "latitude: #{lat} longitude: #{long}"
  end

  #:reek:LongParameterList
  def self.store_session(id, action, photo_uri, location)
    dir = "public/session_#{id}/#{action}s/#{Time.now.to_i}"
    `mkdir -p #{dir}`
    `curl -s #{photo_uri} --output #{dir}/selfie.jpg`
    File.open("#{dir}/geo.txt", 'w') { |file| file.write(location) }
  end

  def self.recruit_list
    list = YAML.load_file('recruit_list.yml')['rubizza_recruits']
    if list
      list.map(&:to_s)
    else
      []
    end
  end

  def self.registered_list
    list = YAML.load_file('registered_list.yml')
    if list
      list.map(&:to_s)
    else
      []
    end
  end

  # :reek:TooManyStatements
  def self.add_to_registered_list(digits)
    camp_num = digits.to_i
    list = YAML.load_file('registered_list.yml')
    if list
      list << camp_num
    else
      list = [camp_num]
    end
    File.open('registered_list.yml', 'w') { |file| file.write(list.to_yaml) }
  end
end
