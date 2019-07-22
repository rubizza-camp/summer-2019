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
require_relative 'data_check'
require_relative 'file_accessor'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand

  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.month }
  end

  def notify(msg)
    respond_with :message, text: msg
  end

  def notify_with_reference(msg)
    reply_with :message, text: msg
  end

  def send_sticker(sticker_id)
    respond_with :sticker, sticker: sticker_id
  end

  def registered?
    return true if session.key?(:number)
    false
  end

  def checkin?
    return true if session[:checkin?]
    respond_with :message, text: 'You got to checkin first'
    false
  end

  def checkout?
    return true if session[:checkout?]
    false
  end
end

TOKEN = ENV['BOT_TOKEN']

bot = Telegram::Bot::Client.new(TOKEN)

require 'logger'

logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
