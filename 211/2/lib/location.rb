require 'fileutils'
require_relative './answers.rb'

class LocationHelper
  include Answers
  attr_reader :bot, :message, :user_id, :latitude, :longitude, :photo

  def initialize(bot, message, user_id, photo)
    @bot = bot
    @message = message
    @user_id = user_id
    @latitude =  message.location.latitude
    @longitude = message.location.longitude
    @photo = photo
  end

  def call(status)
    if check_status == 'checkined' || check_status == 'checkouted'
      return { chat_id: message.chat.id, text: 'Stop Spam at me' }
    end
    create_folder(status)

    if REDIS.get("#{@user_id}_photo").empty?
            FileUtils.rm_rf("#{user_id}/#{status}/#{@timestamp}")
      ask_photo
    else
      @photo.save_img(status, @timestamp)
      save_location(status)
      REDIS.set("#{@user_id}_status", status.gsub(/s$/, 'ed'))
      { chat_id: message.chat.id, text: 'Nice to see you in right place' }
    end
  end

  def create_folder(status)
    puts @timestamp = Time.now.getlocal('+03:00').to_i
    FileUtils.mkdir_p("#{user_id}/#{status}/#{@timestamp}")
  end

  def save_location(status)
    loc = "#{@latitude}, #{@longitude}"
    File.write("#{user_id}/#{status}/#{@timestamp}/location.txt", loc)
  end

  def check_status
    current_status = REDIS.get("#{@user_id}_status")
  end


end
