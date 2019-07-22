require 'telegram/bot'
require 'logger'
require_relative './commands/start'
require_relative './commands/checkin'
require_relative './commands/checkout'
require_relative './commands/additional_methods'

class WebhooksController < Telegram::Bot::UpdatesController

  include Telegram::Bot::UpdatesController::MessageContext
  include Start
  include Checkin
  include Checkout
  include AddMethods

  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

end

TOKEN = '860071708:AAGrfhtaGXROhZJGjP-Bml5tIf0UoKquBM0'

bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
