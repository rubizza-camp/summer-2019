require 'telegram/bot'
require 'redis'
require 'active_support/all'
require 'pry'
require 'fileutils'
require 'open-uri'
require 'json'
require 'time'
require_relative 'commands/start_command'
require_relative 'commands/checkin_command'
require_relative 'commands/checkout_command'
require_relative 'helpers'
require_relative 'verifier'
require_relative 'file_reader'


class WebhooksController < Telegram::Bot::UpdatesController
  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.month }
  end

  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include FileAccessor
  include Helpers
  include Verifier
  include Telegram::Bot::UpdatesController::MessageContext

  def id!
    respond_with :message, text: from['id']
  end

  def clear!(key)
    session.delete(key)
  end

  def show!
    respond_with :message, text: session.inspect
  end

  def message(message)
    binding.pry
    p message
  end
end

TOKEN = ENV['BOT_TOKEN']

bot = Telegram::Bot::Client.new(TOKEN)

require 'logger'

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
