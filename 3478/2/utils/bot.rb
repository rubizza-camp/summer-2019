require 'telegram/bot'
require 'logger'
require 'active_support/all'

class Bot
  def initialize(token)
    @token = token
    @bot = Telegram::Bot::Client.new(@token)
  end

  def start
    start_logger
  end

  private

  def start_logger
    logger = Logger.new(STDOUT)
    poller = Telegram::Bot::UpdatesPoller.new(@bot, WebhooksController, logger: logger)
    poller.start
  end
end
