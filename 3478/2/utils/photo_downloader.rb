# frozen_string_literal: true

require 'open-uri'
require 'json'

module PhotoDownloader
  API_TG_LINK = 'https://api.telegram.org/bot'
  GET_ID_LINK = '/getFile?file_id='

  def download_photo
    tg_api_link = API_TG_LINK + ENV['TELEGRAM_TOKEN'] + GET_ID_LINK + session[:photo_id]
    tg_api_file_path = JSON.parse(URI.open(tg_api_link).read)['result']['file_path']
    URI.open("https://api.telegram.org/file/bot/#{ENV['TELEGRAM_TOKEN']}/#{tg_api_file_path}").read
  end
end
