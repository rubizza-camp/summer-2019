require 'fileutils'
require 'rest-client'

require_relative 'state_changer.rb'

class Photo
  include StateChanger
  attr_reader :bot, :message, :timestamp, :user_id, :folder, :photo_path

  def initialize(message, bot)
    @bot = bot
    @user_id = message.from.id
    @message = message
    @folder = Redis.current.get("#{user_id}_folder")
  end

  def call
    timestamp = Time.now.getlocal('+03:00').to_i
    Redis.current.set("#{user_id}_photo_time", timestamp)
    create_folder(folder, timestamp)
    image_url
    save_img(folder, timestamp)
    "#{message.from.first_name}, where are you?"
  end

  def image_url
    file_id = message.photo[-1].file_id
    file = bot.api.get_file(file_id: file_id)
    file_path = file.dig('result', 'file_path')
    @photo_path = "https://api.telegram.org/file/bot#{Settings.token}/#{file_path}"
  end

  def create_folder(folder, timestamp)
    path = "public/#{Redis.current.get(user_id)}/#{folder}/#{timestamp}"
    FileUtils.mkdir_p(path)
  end

  def save_img(folder, timestamp)
    data = RestClient.get(photo_path).body
    path = "public/#{Redis.current.get(user_id)}/#{folder}/#{timestamp}/selfie.jpg"
    File.write(path, data, mode: 'wb')
    waiting_for_location
  end
end
