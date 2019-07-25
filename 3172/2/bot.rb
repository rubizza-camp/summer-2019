require 'fileutils'
require 'open-uri'
require 'redis'
require 'telegram/bot'
require_relative 'commands/start'
require_relative 'commands/stop'
require_relative 'commands/check_in'
require_relative 'commands/check_out'
require_relative 'user'

class Bot
  # :reek:FeatureEnvy
  # :reek:NestedIterators
  def launch(token)
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        bot_answer = receive_bot_answer(message, bot)
        bot.api.send_message(chat_id: message.chat.id, text: bot_answer)
      end
    end
  end

  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def receive_bot_answer(message, bot)
    user = User.new(message.from.id)
    case message.text
    when '/start'    then Start.fetch_id(user)
    when '/checkin'  then CheckIn.start(user)
    when '/checkout' then CheckOut.start(user)
    when '/stop'     then Stop.stop(user)
    else                  other_input(user, message, bot)
    end
  end

  # :reek:UtilityFunction
  # :reek:TooManyStatements
  # rubocop:disable Metrics/CyclomaticComplexity
  def other_input(user, message, bot)
    case user.state
    when 'start'             then Start.logging_in(user, message)
    when 'ready_checkin'     then 'Enter command /checkin'
    when 'ready_checkout'    then 'Enter command /checkout'
    when 'wait_picture'      then CheckIn.save_url_photo(user, message)
    when 'wait_location'     then CheckIn.save_location(user, message, bot)
    when 'stop' || 'initial' then 'The bot is not running. Press /start'
    else 'wrong command'
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end

print 'Enter token: '
TOKEN = gets.chomp.freeze

Bot.new.launch(TOKEN)
