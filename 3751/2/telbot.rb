require 'telegram/bot'

token = ''

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      question = 'your id'
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: [%w(13 3336), %w(204 211)], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

      kb = [
        Telegram::Bot::Types::KeyboardButton.new(text: 'Give me your phone number', request_contact: true),
        Telegram::Bot::Types::KeyboardButton.new(text: 'Show me your location', request_location: true)
      ]
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
      bot.api.send_message(chat_id: message.chat.id, text: 'Hey!', reply_markup: markup)
      
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end
