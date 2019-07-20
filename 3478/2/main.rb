require 'redis-rails'
require 'dotenv'

require_relative 'utils/bot.rb'
require_relative 'utils/webhooks_controller.rb'

Dotenv.load
controller = Bot.new(ENV['TELEGRAM_TOKEN'])
controller.start
