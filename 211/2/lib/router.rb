require_relative './photo.rb'
require_relative './message.rb'
require_relative './location.rb'
require_relative './user.rb'

class Router
  def self.evaluate(message, bot)
    message_helper = MessageHelper.new(bot, message)
    @user = User.new(message)

    if message_helper.photo?
      puts 'its a photo'
      @photo = PhotoHelper.new(message, bot, TOKEN, message.from.id)
      @photo.call(REDIS.get("#{@user.user_id}_status"))

    elsif message_helper.location?
      LocationHelper.new(bot, message, message.from.id, @photo).call(REDIS.get("#{@user.user_id}_status"))

      { chat_id: message.chat.id, text: 'nice' }
    elsif message_helper
      case message.text
      when '/start'
        # puts message.from.first_name
        # # bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")

        # { chat_id: message.chat.id, text: "Hello, #{message.from.first_name}" }
        @user.ask_registration
      when '/checkin'
        @user.change_status(message)
      when '/checkout'
        # bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        @user.change_status(message)
      when /\d/
        puts 'maybe its id'
        @user.registration(message.text.to_i)
      else
        message_helper.ask_something
      end
    end
  end
end
