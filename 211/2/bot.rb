require 'telegram/bot'
require './lib/router'
require 'redis'
require_relative './lib/user.rb'

TOKEN = 
RRRRedis = Redis.new

Telegram::Bot::Client.run(TOKEN) do |bot|

  bot.listen do |message|

    response = Router.evaluate(message, bot)
    bot.api.send_message(response)
  end #listen

end #run