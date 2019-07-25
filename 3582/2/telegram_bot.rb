require 'telegram/bot'
require './commands/start_command'
require './commands/checkin_command'
require './commands/checkout_command'
require './modules/foolish_message_catcher'
require 'pry'
require 'redis-activesupport'
require 'redis'
class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include FoolishMessageCatcher

  attr_reader :db

  def initialize(*args)
    super(args[0], args[1])
    @db = Redis.new
  end

  private

  def session_key
    from['id'] if from
  end
end

TOKEN = ENV['TELEGRAM_TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)
# rubocop:disable Metrics/LineLength
Telegram::Bot::UpdatesController.session_store = :redis_store, 'https://127.0.0.1:6379', { expires_in: 1_000_000 }
# rubocop:enable Metrics/LineLength

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
