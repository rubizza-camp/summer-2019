require 'fileutils'
require 'json'
require 'net/http'
require 'open-uri'

class Downloader
  class << self
    BOT_API_GETFILE_URL = "https://api.telegram.org/bot#{ENV['BOT_TOKEN']}/getFile".freeze
    BOT_API_STORAGE_URL = "https://api.telegram.org/file/bot#{ENV['BOT_TOKEN']}/".freeze

    def download_photo(photo_id, session)
      save_photo_to_folder('selfie.jpg', file_path(photo_id), session)
    end

    def load_location(location, session)
      save_location_to_folder('geo.txt', location, session)
    end

    private

    def file_path(file_id)
      uri = URI(BOT_API_GETFILE_URL)
      uri.query = URI.encode_www_form(file_id: file_id)
      response = Net::HTTP.get(uri)
      puts JSON.parse(response)
      JSON.parse(response)['result']['file_path']
    end

    def save_location_to_folder(file_name, location, session)
      File.open(folder_path(session) + file_name, 'wb') { |file| file.puts location }
    end

    def save_photo_to_folder(file_name, file_path, session)
      File.open(folder_path(session) + file_name, 'wb') do |file|
        file << URI.parse(BOT_API_STORAGE_URL + file_path).read
      end
    end

    def folder_path(session)
      path = "data/#{session['student_id']}/#{session['command']}/#{session['timestamp']}/"
      FileUtils.mkdir_p(path) unless File.exist?(path)
      path
    end
  end
end
