# frozen_string_literal: true

require 'telegram/bot'
require_relative './commands/start.rb'
require_relative './commands/checkin.rb'
require_relative './commands/checkout.rb'
require_relative './commands/helper.rb'
require 'logger'

# Soure telegramm bot
class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Start
  include Checkin
  include Checkout
  include Helper
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1_000_000 }
end

TOKEN = '--------------------------------------------------'
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start

# OR
# rack-app for webhook mode. See https://rack.github.io/ for details.
# Make sure to run `set_webhook` passing valid url.
# map "/#{TOKEN}" do
#   run Telegram::Bot::Middleware.new(bot, WebhooksController)
# end
