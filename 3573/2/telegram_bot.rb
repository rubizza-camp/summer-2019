require 'telegram/bot'
require 'logger'
require 'dotenv'
require_relative './commands/start'
require_relative './commands/checkin'
require_relative './commands/checkout'
require_relative './commands/additional_methods'
require_relative './commands/download_image'
require_relative './commands/location'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Start
  include Checkin
  include Checkout
  include AddMethods
  include DownloadImage
  include DownloadLocation

  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }
end

Dotenv.load
bot = Telegram::Bot::Client.new(ENV['TOKEN'])

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
