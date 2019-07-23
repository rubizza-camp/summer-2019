require 'telegram/bot'
require 'redis'
require 'fileutils'
require 'date'
require 'dotenv'
require 'logger'
require 'i18n'

Dir[File.join(__dir__, 'command', '*_command.rb')].each { |file| require file }
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'helper', '*.rb')].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext

  I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']

  include Helper
  include MessageRespond
  include StartCommand
  include DeleteCommand
  include CheckinCommand
  include CheckoutCommand
  include EndCommand
end

Dotenv.load
TOKEN = ENV['TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }
