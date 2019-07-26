# frozen_string_literal: true

#saves location in geo.txt
module Location
  def self.save(student, message, folder)
    if message.location
      chat_id = message.chat.id
      timestamp = Time.now
      RedisHelper.set("chat:#{chat_id}:timestamp", timestamp)
      FileUtils.mkdir_p("public/#{student}/#{folder}/#{timestamp}")
      path_to_file = "public/#{student}/#{folder}/#{timestamp}"
      latitude, longitude = message.location.latitude, message.location.longitude
      file = File.open("#{path_to_file}/geo.txt", 'w')
      for_human_location = Geocoder.search([latitude, longitude])
      file.write("Location for human: #{for_human_location.first.address}" + "\n")
      file.write("Location for machine: latitude: #{latitude}, longitude: #{longitude}" + "\n")
      file.write("At time: #{Time.now}" + "\n")
      file.close
      true
    else
      false
    end
  end
end
