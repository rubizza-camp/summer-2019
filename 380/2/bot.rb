<<<<<<< HEAD
<<<<<<< HEAD
=======
require 'bundler'
>>>>>>> 8ef874f22a9a9f5675fca28d5c151f7e1f71fa75
require 'telegram/bot'
Bundler.require

Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'commands', '*.rb')].each { |file| require file }

<<<<<<< HEAD
class RubizzaWatchman
  def initialize
    # to do create storage, token enter
  end

  def run(token, db)
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        Dialog.new(message: message, bot: bot, database: db, chat_id: message.chat.id).validate
      end
    end
  end
end

RubizzaWatchman.new.run(token, db)
=======
require 'bundler'
require 'telegram/bot'
Bundler.require

Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'commands', '*.rb')].each { |file| require file }

Telegram::Bot::Client.run(ENV['TOKEN']) do |bot|
  bot.listen do |message|
    user = User.find(message.from.id)

    result = Router.resolve(message, user)
    binding.pry
    if result.nil?
      bot.api.send_message(chat_id: message.from.id,
                           text: 'Repeat please! try /help to see available commands')
    else
      bot.api.send_message(chat_id: message.from.id, text: result)
    end
  end
end
>>>>>>> 94a9c14... working prototype without ill features
=======
Telegram::Bot::Client.run(ENV['TOKEN']) do |bot|
  bot.listen do |message|
    result = Router.resolve(message, bot)
    if result.nil?
      bot.api.send_message(chat_id: message.from.id,
                           text: 'Repeat please! try /help to see available commands')
    else
      bot.api.send_message(chat_id: message.from.id, text: result)
    end
  end
end
>>>>>>> 8ef874f22a9a9f5675fca28d5c151f7e1f71fa75
