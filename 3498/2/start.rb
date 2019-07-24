require 'redis'
require 'telegram/bot'
require 'logger'
require 'yaml'
require 'active_support/all'
require 'ohm'
require 'date'
require 'fileutils'

require_relative 'lib/command/bot_start_commands.rb'
require_relative 'lib/command/bot_checkin_commands.rb'
require_relative 'lib/command/bot_checkout_commands.rb'
require_relative 'lib/controller/webhooks_controller.rb'
require_relative 'lib/model/user_model.rb'

class Bot
  def initialize(token)
    @bot = Telegram::Bot::Client.new(token)
  end

  def run
    logger = Logger.new(STDOUT)
    poller = Telegram::Bot::UpdatesPoller.new(@bot, WebhooksController, logger: logger)
    poller.start
  end
end

Bot.new(ENV['TG_TOKEN']).run
