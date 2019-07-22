require 'telegram/bot'
require 'open-uri'
require 'fileutils'
require_relative 'commands/start'
require_relative 'commands/stop'
require_relative 'commands/change_status'
require_relative 'helpers/session'

class Bot
  include StartCommand
  include StopCommand
  include ChangeStatusCommand
  include Session

  def launch
    Telegram::Bot::Client.run(TOKEN) do |bot|
      @bot = bot
      bot_lissen(bot)
    end
  end

  def bot_lissen(bot)
    bot.listen do |message|
      chat_id = message.chat.id
      bot_answer = receive_bot_answer(message)
      send_message(chat_id, bot_answer, bot)
    end
  end

  # :reek:UtilityFunction
  def send_message(chat_id, bot_answer, bot)
    bot.api.send_message(chat_id: chat_id, text: bot_answer)
  end

  # :reek:TooManyStatements
  def receive_bot_answer(message)
    user_id = message.from.id
    command = message.text
    case command
    when '/start'    then state_wait_id(message)
    when '/checkin'  then state_wait_picture(user_id, 'checkin')
    when '/checkout' then state_wait_picture(user_id, 'checkout')
    when '/stop'     then stop(user_id)
    else                  other_input(message, user_id)
    end
  end

  # :reek:TooManyStatements
  def other_input(message, user_id)
    session_params = load_session_params(user_id)
    return 'The bot is not running. Press /start' unless session_params
    state = session_params['state']
    case state
    when 'start'        then srarting(message)
    when 'ready'        then 'Enter command /checkin or /checkout'
    when 'wait_picture' then save_url_photo(message)
    when 'wait_locate'  then check_locate(message)
    end
  end
end

TOKEN = '839245120:AAFNkeNCKJTSOkDnx3q9yO94jWOH-bXOTpA'.freeze
Bot.new.launch
