require 'json'
require 'open-uri'
require 'pry'
require_relative 'user_photo'
require_relative 'geoposition'

module Saver
  class FileSaver
    API_URL = 'https://api.telegram.org/'.freeze
    TOKEN = '812391281:AAGbnwP8CdHvhZV5_rNSw9ryuRRbEUroLno'

    def self.data_file(file_id, person_number, folder_name)
      uri = URI("#{API_URL}bot#{TOKEN}/getFile?file_id=#{file_id}")
      json_response = JSON.parse(Net::HTTP.get(uri))
      new.save_photo(json_response['result']['file_path'], person_number, folder_name)
    end

    def self.save_location(location, person_number, folder_name)
      location_path = "#{person_number}/#{folder_name}/#{Date.today}/geo"
      File.write(location_path, location, mode: 'wb')
      location_path
    end

    def save_photo(path, person_number, folder_name)
      uri = URI("#{API_URL}file/bot#{TOKEN}/#{path}")
      FileUtils.mkdir_p("#{person_number}/#{folder_name}/#{Date.today}")
      photo_new_path = "#{person_number}/#{folder_name}/#{Date.today}/photo.jpg"
      File.write(photo_new_path, Kernel.open(uri).read, mode: 'wb')
      photo_new_path
    end
  end
end
