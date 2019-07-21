require 'fileutils'
require 'rest-client'

class PhotoHelper
  attr_reader :bot, :token, :user_id, :message

  def initialize(message, bot, token, user_id)
    @bot = bot
    @token = token
    @user_id = user_id
    @message = message
  end

  def call(_status)
    image_url
    ask_location
  end

  def image_url
    file_id = message.photo[-1].file_id
    puts file = bot.api.get_file(file_id: file_id)
    file_path = file.dig('result', 'file_path')
    @path = "https://api.telegram.org/file/bot#{token}/#{file_path}"
  end

  def save_img(status)
    timestamp = Time.now.getlocal('+03:00').to_i
    data = RestClient.get(@path).body
    File.write("#{user_id}/#{status}/#{timestamp}/selfie.jpg", data, mode: 'wb')
  end

  def ask_location
    { chat_id: message.chat.id, text: "#{message.from.first_name}, where are you?" }
  end
end
