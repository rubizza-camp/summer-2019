# frozen_string_literal: true

#saves location in geo.txt
module Location
  def self.save(chat_id, student, message, folder)
    if message.location
      data = fetch_data(message)
      RedisDo.set("chat:#{chat_id}:timestamp", data[:timestamp])
      FileUtils.mkdir_p("public/#{student}/#{folder}/#{data[:timestamp]}")
      file = File.open("public/#{student}/#{folder}/#{data[:timestamp]}/geo.txt", 'w')
      file.write("Adress: #{data[:address].first.address}" + "\n")
      file.write("Coordinates: #{data[:latitude]}, longitude: #{data[:longitude]}" + "\n")
      file.close
      true
    else
      false
    end
  end

  def self.fetch_data(message)
    latitude, longitude = message.location.latitude, message.location.longitude
    data = {latitude: latitude,
            longitude: longitude,
            address: Geocoder.search([latitude, longitude]),
            timestamp:Time.now}
    end
  end
