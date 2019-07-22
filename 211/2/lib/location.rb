require 'fileutils'
require_relative './answers.rb'

class LocationHelper
  include Answers
  attr_reader :bot, :message, :user_id, :loc, :photo

  def initialize(bot, message, photo)
    @bot = bot
    @message = message
    @user_id = message.from.id
    @loc = %(latitude: #{message.location.latitude},
            longitude: #{message.location.longitude})
    @photo = photo
  end

  def call(status)
    if check_status == 'checkined' || check_status == 'checkouted'
      return { chat_id: message.chat.id, text: 'Stop Spam at me' }
    end
    create_folder(status)

    if REDIS.get("#{@user_id}_photo").empty?
      FileUtils.rm_rf("public/#{user_id}/#{status}/#{@timestamp}")
      ask_photo
    else
      @photo.save_img(status, @timestamp)
      save_location(status)
    end
  end

  def create_folder(status)
    puts @timestamp = Time.now.getlocal('+03:00').to_i
    FileUtils.mkdir_p("public/#{user_id}/#{status}/#{@timestamp}")
  end

  def save_location(status)
    File.write("public/#{user_id}/#{status}/#{@timestamp}/location.txt", @loc)
    REDIS.set("#{@user_id}_status", status.gsub(/s$/, 'ed'))
    { chat_id: message.chat.id, text: 'Nice to see you in right place' }
  end
end
