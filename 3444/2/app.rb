require 'dotenv/load'
require 'telegram/bot'
require 'redis-activesupport'
require 'time'
require 'yaml'
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  self.session_store = :redis_store, { expires_in: 100_000 }

  include Start
  include CheckIn
  include CheckOut
end

TOKEN = ENV.fetch('token')
bot = Telegram::Bot::Client.new(TOKEN)
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
