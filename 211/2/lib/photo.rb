require 'fileutils'
require 'rest-client'
require_relative './answers.rb'

class PhotoHelper
  include Answers
  attr_reader :bot, :token, :user_id, :message

  def initialize(message, bot, token, user_id)
    @bot = bot
    @token = token
    @user_id = user_id
    @message = message
  end

  def call
    if check_status == 'checkined' || check_status == 'checkouted'
      return { chat_id: message.chat.id, text: 'Stop Spam at me' }
    end
    image_url
    ask_location
  end

  def image_url
    file_id = message.photo[-1].file_id
    puts file = bot.api.get_file(file_id: file_id)
    file_path = file.dig('result', 'file_path')
    path = "https://api.telegram.org/file/bot#{token}/#{file_path}"
    REDIS.set("#{@user_id}_photo", path)
  end

  def save_img(status, timestamp)
    path = REDIS.get("#{@user_id}_photo")
    if path.empty?
      ask_photo
    else
      data = RestClient.get(path).body
      File.write("public/#{user_id}/#{status}/#{timestamp}/selfie.jpg", data, mode: 'wb')
      REDIS.set("#{@user_id}_photo", nil)
    end
  end

  def ask_location
    { chat_id: message.chat.id, text: "#{message.from.first_name}, where are you?" }
  end
end
