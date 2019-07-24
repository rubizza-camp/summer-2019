require 'fileutils'

require_relative 'status.rb'

class LocationHelper
  include StatusChanger
  attr_reader :message, :loc, :photo, :user_id

  def initialize(message, photo)
    @message = message
    @user_id = message.from.id
    @loc = "latitude: #{message.location.latitude},"\
           "longitude: #{message.location.longitude}"
    @photo = photo
  end

  def call(status)
    save_location(status, photo.timestamp)
  end

  def save_location(status, timestamp)
    File.write("public/#{Settings.redis.get(user_id)}/#{status}/#{timestamp}/location.txt", loc)
    Settings.redis.set("#{user_id}_status", status.gsub(/s$/, 'ed'))
    final_status(status)
    'Nice to see you in right place'
  end
end
