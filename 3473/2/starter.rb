# frozen_string_literal: true

require 'telegram/bot'
require 'logger'
require_relative './overlooker'

SEC_IN_MONTH = 2_678_400

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2 * SEC_IN_MONTH }
token = YAML.load_file('data/config.yml').to_h['token'].to_a.first
bot = Telegram::Bot::Client.new(token, 'overlooker')
Telegram.bots_config = {
  default: token
}
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
