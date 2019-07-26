require 'telegram/bot'
require './commands/start'
require './commands/help'
require './reg.rb'
require 'redis'
require 'pry'
require 'dotenv'
require './commands/checkin'
# require './commands/checkout'

class WebhooksController < Telegram::Bot::UpdatesController
  include Start
  include Reg
  include CheckIn
  # include CheckOut
  include Help
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  self.session_store = :redis_store, { expires_in: 525_600.hours }
end

Dotenv.load
bot = Telegram::Bot::Client.new(ENV['TOKEN'])

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
