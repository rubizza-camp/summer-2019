require 'fileutils'
require_relative './answers.rb'
require_relative './status.rb'

class LocationHelper
  include Answers
  include StatusChanger
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
    REDIS.get("#{@user_id}_status")
    @photo.nil? ? ask_photo : save_location(status, @photo.timestamp)
  end

  def save_location(status, timestamp)
    File.write("public/#{REDIS.get(@message.from.id)}/#{status}/#{timestamp}/location.txt", @loc)
    REDIS.set("#{@user_id}_status", status.gsub(/s$/, 'ed'))
    final_status(status)
    'Nice to see you in right place'
  end
end
