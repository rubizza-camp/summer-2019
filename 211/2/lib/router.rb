require_relative './photo.rb'
require_relative './location.rb'
require_relative './user.rb'

class Router
  def self.resolve(message, bot)
    user = User.new(message)

    status = REDIS.get("#{message.from.id}_status")
    state = REDIS.get("#{message.from.id}_state")
    if !message.photo.empty?
      create_photo(message, state, status, bot, user)
    elsif message.location
      create_location(message, state, status, bot, user)
    elsif message
      user.answer_to_request
    end
  end

  def self.create_photo(message, state, status, bot, _user)
    if state == 'waiting for photo'
      @timestamp = Time.now.getlocal('+03:00').to_i
      @photo = PhotoHelper.new(message, bot, TOKEN)
      @photo.call(status, @timestamp)
    else
      "Nope. don't need your photo"
    end
  end

  def self.create_location(message, state, status, bot, _user)
    if state == 'waiting for location'
      @location = LocationHelper.new(bot, message, @photo)
      @location.call(status)
    else
      "Nope. don't need your location"
    end
  end
end
