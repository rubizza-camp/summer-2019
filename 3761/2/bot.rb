require 'telegram/bot'
require 'redis'
require 'fileutils'
require 'date'
require './helper/redis_helper.rb'

Dir[File.join(__dir__, 'command', '*_command.rb')].each { |file| require file }
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include RedisHelper
  include StartCommand
  include DeleteCommand
  include CheckinCommand
  include CheckoutCommand
  include EndCommand
end

bot = Telegram::Bot::Client.new(TOKEN)

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start

map "/#{TOKEN}" do
  run Telegram::Bot::Middleware.new(bot, WebhooksController)
end
