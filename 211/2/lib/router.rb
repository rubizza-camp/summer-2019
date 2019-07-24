require_relative 'location_helper.rb'
require_relative 'photo_helper.rb'
require_relative 'user.rb'
require_relative 'settings.rb'

class Router
  # rubocop: disable Metrics/AbcSize
  def self.resolve(message, bot)
    user = User.new(message)
    status = Settings.redis.get("#{message.from.id}_status")
    state = Settings.redis.get("#{message.from.id}_state")

    if !message.photo.empty?
      create_photo(message, state, status, bot)
    elsif message.location
      create_location(message, state, status)
    elsif message
      user.answer_to_request
    end
  end
  # rubocop: enable Metrics/AbcSize

  def self.create_photo(message, state, status, bot)
    if state == 'waiting for photo'
      @photo = PhotoHelper.new(message, bot)
      @photo.call(status)
    else
      "Nope. don't need your photo"
    end
  end

  def self.create_location(message, state, status)
    if state == 'waiting for location'
      location = LocationHelper.new(message, @photo)
      location.call(status)
    else
      "Nope. don't need your location"
    end
  end
end
