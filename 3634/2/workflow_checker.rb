require 'active_support/time'
require 'dotenv/load'
require 'logger'
require 'redis'
require 'telegram/bot'
require_relative 'commands/check_in'
require_relative 'commands/check_out'
require_relative 'commands/start'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include StartCommand
  include CheckInCommand
  include CheckOutCommand

  self.session_store = :redis_store, { expires_in: 1.month }

  def chat_session
    @chat_session ||= self.class.build_session('global_session')
  end

  def process_action(*)
    super
  ensure
    chat_session.commit
  end
end

TOKEN = ENV['TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
