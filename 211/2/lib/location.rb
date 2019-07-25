require 'fileutils'

require_relative 'state_changer.rb'

class Location
  include StateChanger
  attr_reader :message, :loc, :user_id, :folder

  def initialize(message)
    @message = message
    @user_id = message.from.id
    @loc = "latitude: #{message.location.latitude},"\
           "longitude: #{message.location.longitude}"
    @folder = Redis.current.get("#{user_id}_folder")
  end

  def call
    timestamp = Redis.current.get("#{user_id}_photo_time")
    save_location(folder, timestamp)
  end

  def save_location(folder, timestamp)
    File.write("public/#{Redis.current.get(user_id)}/#{folder}/#{timestamp}/location.txt", loc)
    final_state(folder)
    'Nice to see you in right place'
  end
end
