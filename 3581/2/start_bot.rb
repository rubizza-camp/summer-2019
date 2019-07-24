require 'active_support/all'
require 'dotenv/load'
require 'i18n'
require 'telegram/bot'
require 'logger'
require 'redis-rails'
require './commands/command_start.rb'
require './commands/command_checkin.rb'
require './commands/command_checkout.rb'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include CommandStart
  include CommandCheckin
  include CommandCheckout

  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

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
I18n.load_path << Dir[File.expand_path('config/local_msg') + '/*.yml']
# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
