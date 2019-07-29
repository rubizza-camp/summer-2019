require 'telegram/bot'
require './commands/start'
require './commands/checkin'
require './commands/checkout'
require './commands/help'
require './commands/logout'
require 'redis'
require 'redis-activesupport'
require 'ohm'
require 'dotenv/load'
require 'i18n'
require 'net/http'
require 'logger'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include Help
  include Logout

  self.session_store = :redis_store, { expires_in: 100_000 }
end
bot = Telegram::Bot::Client.new(ENV['TOKEN'])
I18n.load_path << Dir[File.expand_path('config/locales') + '/ru.yml']
I18n.default_locale = :ru
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
