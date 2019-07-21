# frozen_string_literal: true

require 'telegram/bot'
require 'logger'
require 'redis'
require 'redis-store'
require 'redis-rails'
require 'yaml'
require './commands/start_command'
require './commands/login_command'
require './commands/check_commands'
require './commands/logout_command'

class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include LoginCommand
  include CheckCommands
  include LogoutCommand
  include Telegram::Bot::UpdatesController::MessageContext

  SEC_IN_MONTH = 2_678_400

  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2 * SEC_IN_MONTH }
  end
end

token = YAML.load_file('data/config.yml')['token'].first
bot = Telegram::Bot::Client.new(token, 'overlooker')
Telegram.bots_config = {
  default: token
}
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
