require 'net/http'
require 'open-uri'

# module that download photo
module PhotoHelper
  API = "https://api.telegram.org/bot#{ENV['TOKEN']}/getFile?file_id=".freeze
  DOWNLOAD_API = "https://api.telegram.org/file/bot#{ENV['TOKEN']}".freeze

  def photo_path
    file_id = payload['photo'].last['file_id']
    json_response = URI.open("#{API}#{file_id}").read
    JSON.parse(json_response, symbolize_names: true).dig(:result, :file_path)
  end

  def save_photo(checkin_path)
    File.open("#{checkin_path}/photo.jpg", 'wb') do |file|
      file << URI.open("#{DOWNLOAD_API}/#{photo_path}").read
    end
  end
end
