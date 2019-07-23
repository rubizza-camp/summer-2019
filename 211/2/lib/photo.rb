require 'fileutils'
require 'rest-client'
require_relative './answers.rb'
require_relative './status.rb'

class PhotoHelper
  include Answers
  include StatusChanger
  attr_reader :bot, :token, :message, :timestamp, :user_id

  def initialize(message, bot, token)
    @bot = bot
    @token = token
    @user_id = message.from.id
    @message = message
  end

  def call(status, time)
    @timestamp = time
    REDIS.get("#{user_id}_status")
    create_folder(status)
    image_url
    save_img(status, timestamp)
    ask_location
  end

  def image_url
    file_id = message.photo[-1].file_id
    file = bot.api.get_file(file_id: file_id)
    file_path = file.dig('result', 'file_path')
    path = "https://api.telegram.org/file/bot#{token}/#{file_path}"
    REDIS.set("#{user_id}_photo", path)
  end

  def create_folder(status)
    path = "public/#{REDIS.get(user_id)}/#{status}/#{timestamp}"
    FileUtils.mkdir_p(path)
  end

  def save_img(status, timestamp)
    path = REDIS.get("#{user_id}_photo")
    if path.empty?
      ask_photo
    else
      data = RestClient.get(path).body
      path = "public/#{REDIS.get(user_id)}/#{status}/#{timestamp}/selfie.jpg"
      File.write(path, data, mode: 'wb')
      REDIS.set("#{user_id}_photo", nil)
      waiting_for_location
    end
  end
end
