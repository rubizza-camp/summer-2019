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
