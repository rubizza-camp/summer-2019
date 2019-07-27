# frozen_string_literal: true

require 'telegram/bot'
require './commands/start'
require './commands/checkin'
require './commands/checkout'

class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include CheckInCommand
  include CheckOutCommand
  include Telegram::Bot::UpdatesController::MessageContext

  def initialize(*args)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }
  end
end

bot_token = ENV['BOT_TOKEN']
abort('Add "BOT_TOKEN" to environment to make bot alive!') unless bot_token
bot = Telegram::Bot::Client.new(bot_token)

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
