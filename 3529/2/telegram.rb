require 'telegram/bot'
require 'httparty'
require 'open-uri'
require 'logger'
require './telegram_runner'

Dir[File.dirname(__FILE__) + '/Lib/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/Lib/Utiles/*.rb'].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  include ContextHandler
  include Telegram::Bot::UpdatesController::MessageContext

  def initialize(_one, _two)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 100_000_000 }
  end
end

telegram_run = TelegramRunner.new
bot = telegram_run.run
TOKEN = bot.token

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
