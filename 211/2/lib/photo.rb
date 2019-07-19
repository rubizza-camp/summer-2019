require "open-uri"
require 'fileutils'
class PhotoHelper
  attr_reader :bot, :token, :user_id, :message
  

  def initialize(message, bot, token, user_id)
    @bot = bot
    @token = token
    @user_id = user_id
    @message = message
  end
  def call(status)
    image_url
    # save_img(status)
    ask_location
  end

  def image_url
    # file_id = bot.api.get_updates.dig('result',0,'message','photo',-1,'file_id')
    file_id = message.photo[0].file_id
    file = bot.api.get_file(file_id: file_id)
    file_path = file.dig('result', 'file_path')
    @path =  "https://api.telegram.org/file/bot#{token}/#{file_path}"
   
  end

  def save_img(status)
    timestamp = Time.now.getlocal('+03:00').to_i
    # FileUtils.mkdir_p("#{user_id}/#{timestamp}") 
    open(@path) do |f|
      File.open("#{user_id}/#{status}/#{timestamp}/selfie.jpg","wb") do |file|
        file.puts f.read
      end
    end
  end

  def ask_location
    {chat_id: message.chat.id, text: "#{message.from.first_name}, where are you?"}
  end


end


