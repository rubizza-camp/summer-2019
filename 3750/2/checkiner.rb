require 'telegram/bot'
require 'redis'
require 'active_support/all'
require 'fileutils'
require 'open-uri'
require 'json'
require 'time'
require 'yaml'
require_relative 'commands/start_command'
require_relative 'commands/checkin_command'
require_relative 'commands/checkout_command'
require_relative 'helpers'
require_relative 'data_check_conversation'
require_relative 'file_accessor'
require_relative 'path_generator'
require_relative 'saver'
require_relative 'validators/geo_validator'
require_relative 'validators/photo_validator'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include Helpers
  include DataCheckConversation
  include PathGenerator
  include Saver
  include GeoValidator
  include PhotoValidator

  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.month }
  end
end

TOKEN = ENV['BOT_TOKEN']

bot = Telegram::Bot::Client.new(TOKEN)

require 'logger'

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
