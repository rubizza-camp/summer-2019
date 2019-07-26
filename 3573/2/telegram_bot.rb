require 'telegram/bot'
require 'logger'
require 'dotenv'
Dir[File.join(__dir__, 'commands', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, ['helpers', '*.rb'])].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  SESSION_TIME = 2_592_000

  include Telegram::Bot::UpdatesController::MessageContext
  include Start
  include Checkin
  include Checkout
  include DownloadImageHelper
  include DownloadLocationHelper
  include UserHelper
  include SessionsHelper
  include ValidationGeoPosition

  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: SESSION_TIME }

  I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
end

bot = Telegram::Bot::Client.new(ENV['TOKEN'])

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
