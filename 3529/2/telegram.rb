require 'telegram/bot'
require 'yaml'
require 'httparty'
require 'open-uri'
require_relative 'start_context'
require_relative 'checkin_context'
require_relative 'checkout_context'

class WebhooksController < Telegram::Bot::UpdatesController
  include StartContext
  include CheckinContext
  include CheckoutContext
  include Telegram::Bot::UpdatesController::MessageContext

  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 100_000_000 }
  end
end

file_token = YAML.safe_load(File.read('Data/token.yaml'))
TOKEN = file_token['token'].freeze
bot = Telegram::Bot::Client.new(TOKEN)
Telegram.bots_config = {
  default: TOKEN
}

require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
