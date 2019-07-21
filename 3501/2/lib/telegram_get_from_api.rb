require 'net/http'
require 'json'
require 'open-uri'
require 'securerandom'
require 'fileutils'

class TelegramGetFromApi
  API_URL = 'https://api.telegram.org/'.freeze
  TEMP_FILES_PATH = 'public/tempData/'.freeze
  # https://api.telegram.org/bot<bot_token>/getFile?file_id=the_file_id
  # https://api.telegram.org/file/bot<token>/<file_path>

  def initialize(bot_token, bot_webhook)
    @bot_token = bot_token
    @bot_webhook = bot_webhook
  end

  def call
    request_file_path(@bot_webhook.payload['photo'].last['file_id'])
  rescue NoMethodError
    nil
  end

  def self.photo_from_file_id(bot_token, bot_webhook)
    new(bot_token, bot_webhook).call
  end

  def request_file_path(file_id)
    uri = URI("#{API_URL}bot#{@bot_token}/getFile?file_id=#{file_id}")
    json_response = JSON.parse(Net::HTTP.get(uri))
    load_file_from_path(json_response['result']['file_path'])
  end

  def load_file_from_path(file_path)
    uri = URI("#{API_URL}file/bot#{@bot_token}/#{file_path}")
    photo_new_path = "#{TEMP_FILES_PATH}#{photo_new_path}#{SecureRandom.hex(10)}.jpg"
    FileUtils.mkdir_p(File.dirname(photo_new_path))
    File.write(photo_new_path, ::Kernel.open(uri).read, mode: 'wb')
    photo_new_path
  end
end
