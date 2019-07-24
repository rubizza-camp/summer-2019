require 'telegram/bot'
require 'yaml'
require 'httparty'
require 'open-uri'
require 'logger'

Dir[File.dirname(__FILE__) + '/Lib/*.rb'].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  include ContextHandler
  include Telegram::Bot::UpdatesController::MessageContext

  def initialize(_one, _two)
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

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
