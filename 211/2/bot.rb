require 'telegram/bot'
require './lib/router'
require 'redis'
require_relative './lib/user.rb'

TOKEN = '768080309:AAHjV0X2XuU4H75uHt1cJ59w62jTrj5L_UQ'
RRRRedis = Redis.new

Telegram::Bot::Client.run(TOKEN) do |bot|

  bot.listen do |message|

    response = Router.evaluate(message, bot)
    bot.api.send_message(response)
  end #listen

end #run