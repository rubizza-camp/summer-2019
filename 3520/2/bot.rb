require 'telegram/bot'
require 'logger'

class WebhooksController < Telegram::Bot::UpdatesController
  def start!(*)
    respond_with :message, text: 'Hello!'
  end

  def checkin!(*)
    respond_with :message, text: 'Пришли мне себяшку:'
  end
end

TOKEN = ENV["CAMP_BOT_TOKEN"]
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
