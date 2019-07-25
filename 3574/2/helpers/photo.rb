require 'open-uri'
require 'json'

module Photo
  BOT_PATH = "https://api.telegram.org/bot#{ENV['TOKEN']}/".freeze
  BOT_PATH_FOR_DOWNLOAD = "https://api.telegram.org/file/bot#{ENV['TOKEN']}/".freeze

  private

  def path_to_photo(file_id)
    url = "#{BOT_PATH}getFile?file_id=#{file_id}"
    raw_json = URI.open(url).read
    JSON.parse(raw_json, symbolize_names: true).dig(:result, :file_path)
  end

  def photo_for_download
    URI.open(BOT_PATH_FOR_DOWNLOAD + session[:path_to_photo])
  end
end
