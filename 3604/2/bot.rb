require 'telegram/bot'
require 'logger'
require 'dotenv'
Dir[File.join('./modules', '*.rb')].each { |file| require_relative file }

class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include DeleteCommand
  include PhotoDownloader
  include GeoDownloader
  include RedisHelper
end

Dotenv.load
bot = Telegram::Bot::Client.new(ENV['TOKEN'])

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
