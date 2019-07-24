require 'telegram/bot'
require './commands/start'
require './commands/help'
require './reg.rb'
require 'redis'
require 'pry'
# require './commands/checkin'
# require './commands/checkout'

class WebhooksController < Telegram::Bot::UpdatesController
  include Start
  include Reg
  # include CheckIn
  # include CheckOut
  include Help
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  self.session_store = :redis_store, {expires_in: 525_600.hours}
end

TOKEN = '982875832:AAHLj_8gdf0tI6RDBVKGCXaN22nUkBCcrqY'
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start