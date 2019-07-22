require_relative './photo.rb'
require_relative './message.rb'
require_relative './location.rb'
require_relative './user.rb'


class Router
  def self.evaluate(message, bot)
    message_helper = MessageHelper.new(bot, message)
    @user = User.new(message)

    if message_helper.photo?
      @photo = PhotoHelper.new(message, bot, TOKEN, message.from.id)
      @photo.call
    elsif message_helper.location?
      LocationHelper.new(bot, message, message.from.id, @photo).call(REDIS.get("#{@user.user_id}_status"))
    elsif message_helper
      case message.text
      when '/start'
        @user.check_registration
      when '/checkin'
        @user.change_status(message)
      when '/checkout'
        @user.change_status(message)
      when /\d/
        @user.registration(message.text.to_i)
      else
        message_helper.ask_something
      end
    end
  end
end
