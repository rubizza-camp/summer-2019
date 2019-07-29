# frozen_string_literal: true

#saves location in geo.txt
module Location
  def self.save(chat_id, student, message, folder)
    if message.location
      data = fetch_data(chat_id, message, student, folder)
      write_in_file(data)
      true
    end
  end

  def self.write_in_file(data)
    RedisDo.set("chat:#{data[:chat_id]}:timestamp", data[:timestamp])
    FileUtils.mkdir_p("public/#{data[:student]}/#{data[:folder]}/#{data[:timestamp]}")
    file = File.open("public/#{data[:student]}/#{data[:folder]}/#{data[:timestamp]}/geo.txt", 'w')
    file.write("Adress: #{data[:address].first.address}" + "\n")
    file.write("Coordinates: #{data[:latitude]}, longitude: #{data[:longitude]}" + "\n")
    file.close
  end

  def self.fetch_data(chat_id, message, student, folder)
    latitude, longitude = message.location.latitude, message.location.longitude
    data = {latitude: latitude,
            longitude: longitude,
            address: Geocoder.search([latitude, longitude]),
            timestamp:Time.now,
            chat_id: chat_id,
            student: student,
            folder: folder}
    end
  end
