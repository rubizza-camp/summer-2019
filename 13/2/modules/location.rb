# frozen_string_literal: true

#saves location in geo.txt
module Location
  def self.save(path_to_file, message)
    if message.location
      puts "condition in Location:  #{message.location}"
      latitude, longitude = message.location.latitude, message.location.longitude
      file = File.open("#{path_to_file}/geo.txt", 'w')
      file.write("Location: latitude: #{latitude}, longitude: #{longitude}")
      file.close
      true
    else
      false
    end
  end
end
