require 'fileutils'
require 'rest-client'

require_relative 'status.rb'

class PhotoHelper
  include StatusChanger
  attr_reader :bot, :message, :timestamp, :user_id

  def initialize(message, bot)
    @bot = bot
    @user_id = message.from.id
    @message = message
  end

  def call(status)
    @timestamp = Time.now.getlocal('+03:00').to_i
    Settings.redis.get("#{user_id}_status")
    create_folder(status)
    image_url
    save_img(status, timestamp)
    "#{message.from.first_name}, where are you?"
  end

  def image_url
    file_id = message.photo[-1].file_id
    file = bot.api.get_file(file_id: file_id)
    file_path = file.dig('result', 'file_path')
    path = "https://api.telegram.org/file/bot#{Settings.token}/#{file_path}"
    Settings.redis.set("#{user_id}_photo", path)
  end

  def create_folder(status)
    path = "public/#{Settings.redis.get(user_id)}/#{status}/#{timestamp}"
    FileUtils.mkdir_p(path)
  end

  def save_img(status, timestamp)
    path = Settings.redis.get("#{user_id}_photo")
    data = RestClient.get(path).body
    path = "public/#{Settings.redis.get(user_id)}/#{status}/#{timestamp}/selfie.jpg"
    File.write(path, data, mode: 'wb')
    Settings.redis.set("#{user_id}_photo", nil)
    waiting_for_location
  end
end
