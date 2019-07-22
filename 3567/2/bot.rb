require 'telegram/bot'
require './lib/commands/start'
require './lib/commands/check_in'
require './lib/commands/check_out'
require 'logger'
require 'redis-rails'
require 'active_support/all'
require 'dotenv/load'
class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include StartCommand
  include CheckinCommand
  include CheckoutCommand

  self.session_store = :redis_store, { expires_in: 2_590_000 }

  def chat_session
    @chat_session ||= self.class.build_session('bot_session')
  end

  def process_action(*)
    super
  ensure
    chat_session.commit
  end
end

bot = Telegram::Bot::Client.new(ENV['TOKEN'])

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
