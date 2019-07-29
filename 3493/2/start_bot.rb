require 'telegram/bot'
require 'date'
require 'active_support/all'
require 'redis'
require 'ohm'
require 'logger'
require 'pry'
require_relative './commands/start_command/start'
require_relative './commands/checkin_command/checkin'
require_relative './commands/checkout_command/checkout'
require_relative './commands/selfie_command/selfie'
require_relative './commands/geoposition_command/geoposition'

class WebhooksController < Telegram::Bot::UpdatesController
  self.session_store = :redis_store, { expires_in: 2.month }
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include SelfieCommand
  include GeopositionCommand
  Ohm.redis = Redic.new(ENV['REDIS'])
end

bot = Telegram::Bot::Client.new(ENV['TOKEN'])
Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: Logger.new(STDOUT)).start
