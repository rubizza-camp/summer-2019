# frozen_string_literal: true

#saves location in geo.txt
module Location
  def self.save
    latitude, longitude = message.location.latitude, message.location.longitude
    file = File.open("#{timestamp}/geo.txt", "w")
    file.write("Location: latitude: #{latitude}, longitude: #{longitude}")
    file.close
  end
end
