require_relative 'lib/user_sessions_controller'
require_relative 'lib/option_controller'
require_relative 'lib/str_container'
require_relative 'commands/clear'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'commands/message'
require 'telegram/bot'
require 'logger'
require 'redis'
require 'active_support/all'

module Telegram
  class WebhookController < Telegram::Bot::UpdatesController
    self.session_store = :redis_store, { expires_in: 1.year }
    include Telegram::Bot::UpdatesController::Session
    include StartCommand
    include CheckinCommand
    include CheckoutCommand
    include MessageCommand
    # for debug purposes
    # include ClearCommand

    private

    def start_first
      respond_with(:message, text: StrContainer.new_start)
    end

    # In this case session will persist for user only in specific chat.
    # Same user in other chat will have different session.
    def session_key
      "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
    end
  end
end

TOKEN = OptionController.options[:bot_token]

bot = Telegram::Bot::Client.new(TOKEN)

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, Telegram::WebhookController, logger: logger)
poller.start
