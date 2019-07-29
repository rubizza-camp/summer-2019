require_relative 'location.rb'
require_relative 'photo.rb'
require_relative 'user.rb'
require_relative 'settings.rb'

class EventHandler
  def self.resolve(message, bot)
    user = User.new(message)
    state = Redis.current.get("#{message.from.id}_state")

    if !message.photo.empty?
      create_photo(message, state, bot)
    elsif message.location
      create_location(message, state)
    elsif message
      answer_to_request(message, user)
    end
  end

  def self.create_photo(message, state, bot)
    if state == 'waiting for photo'
      Photo.new(message, bot).call
    else
      "Nope. don't need your photo"
    end
  end

  def self.create_location(message, state)
    if state == 'waiting for location'
      Location.new(message).call
    else
      "Nope. don't need your location"
    end
  end

  def self.answer_to_request(message, user)
    case message.text
    when '/start' then user.starting
    when '/checkin' then user.checking_in
    when '/checkout' then user.checking_out
    when /\d/
      Redis.current.get(message.from.id) ? user.help_message : user.registration(message.text.to_i)
    else user.help_message
    end
  end
end
