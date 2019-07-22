require_relative './photo.rb'
require_relative './message.rb'
require_relative './location.rb'
require_relative './user.rb'

class Router
  # rubocop: disable Metrics/MethodLength
  def self.resolve(message, bot)
    user = User.new(message)
    message_helper = MessageHelper.new(bot, message, user)
    status = REDIS.get("#{message.from.id}_status")
    state = REDIS.get("#{message.from.id}_state")
    if message_helper.photo?
      create_photo(message, state, status, bot, user)
    elsif message_helper.location?
      create_location(message, state, status, bot, user)
    elsif message_helper
      user.answer_to_request
    end
  end

  # rubocop: enable Metrics/MethodLength
  def self.create_photo(message, state, status, bot, _user)
    if state == 'waiting for photo'
      @timestamp = Time.now.getlocal('+03:00').to_i
      @photo = PhotoHelper.new(message, bot, TOKEN)
      @photo.call(status, @timestamp)
    else
      { chat_id: message.chat.id, text: "Nope. don't need your photo" }
    end
  end

  def self.create_location(message, state, status, bot, _user)
    if state == 'waiting for location'
      @location = LocationHelper.new(bot, message, @photo)
      @location.call(status)
    else
      { chat_id: message.chat.id, text: "Nope. don't need your location" }
    end
  end
end
