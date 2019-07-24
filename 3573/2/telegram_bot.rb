require 'telegram/bot'
require 'logger'
require 'dotenv'
Dir[File.join(__dir__, 'commands', '*.rb')].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Start
  include Checkin
  include Checkout
  include AdditionalMethods
  include DownloadImage
  include DownloadLocation

  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

  I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]
end

bot = Telegram::Bot::Client.new(ENV['TOKEN'])

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
