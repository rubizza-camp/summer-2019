require 'telegram/bot'
require 'redis'
require_relative './commands/start'
require_relative './commands/message'
require_relative './commands/checkin'
require_relative './commands/checkout'
require_relative './commands/nil'
# in this class we create bot

class StartCommand < Telegram::Bot::UpdatesController
  include Start
  include Message
  include Checkin
  include Checkout
  # delete after testing
  include Nil
end

TOKEN = ''
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, StartCommand, logger: logger)
poller.start
