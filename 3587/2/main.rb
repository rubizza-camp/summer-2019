# frozen_string_literal: true

require 'telegram/bot'
require 'logger'
require 'dotenv'
require './commands/start.rb'
require './commands/checkin.rb'
require './commands/checkout.rb'
require './commands/delete.rb'
require './commands/helper.rb'

Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

Dotenv.load
TOKEN = ENV['TOKEN']

class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include DeleteCommand
  include Helper
end

bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
