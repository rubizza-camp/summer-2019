require 'telegram/bot'
require 'active_support/time'
require 'pry'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  self.session_store = :redis_store, {expires_in: 1.month}

  def start!(*)
    if registered?
      respond_with :message, text: 'You are already registered.'
    else
      save_context :number_set
      respond_with :message, text: 'Hello! Give me your personal number.'
    end
  end

  def number_set(number)
    if exist? number
      session[session_key] ||= number
      respond_with :message, text: 'Success! Registration completed.'
    else
      save_context :number_set
      respond_with :message, text: 'Wrong number. Try again.'
    end
  end

  def exist?(number)
    File.open('data/numbers.txt').each do |file_number|
      p file_number
      return true if number == file_number.gsub(/[^0-9]/, '')
    end
    false
  end

  def registered?
    session[session_key]
  end
end

TOKEN = ENV['BOT_TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)

require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
