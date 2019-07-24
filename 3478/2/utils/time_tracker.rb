require 'telegram/bot'
require 'logger'
require 'dotenv'
require 'active_support/all'

class TimeTracker
  def initialize
    load_dotenv
    @bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
  end

  def start
    start_logger
  end

  private

  def load_dotenv
    Dotenv.load
  end

  def start_logger
    logger = Logger.new(STDOUT)
    poller = Telegram::Bot::UpdatesPoller.new(@bot, WebhooksController, logger: logger)
    poller.start
  end
end
