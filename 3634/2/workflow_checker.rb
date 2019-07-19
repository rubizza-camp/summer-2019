require 'telegram/bot'

class WebhooksController < Telegram::Bot::UpdatesController
  def start!(*)
    respond_with :message, text: 'Hello!'
  end
end

TOKEN = '947084823:AAHdYR3Rkz_J1Ne2q4iTnRnRd5PPYTjPp-M'
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start

