require 'telegram/bot'
require 'logger'
require 'redis'
require 'active_support/all'
require 'fileutils'
require 'open-uri'
require 'json'
require 'time'
require 'yaml'
require_relative 'file_accessor'
require_relative 'webhooks_controller'
require_relative 'path_generator'

MSG = {
  success_registration: 'Registration done',
  failure: 'There is no such number in my list',
  already_registered: 'No need to register again',
  number_request: 'Hello! Tell me your Number',
  not_registered: "You got to register first.
    This will be easy, just type in /start command and I'll check your number in list",
  not_checkout: 'You need to /checkout from current shift
    before you can /checkin in a new one',
  success_check_start: 'Show me yourself first',
  success_checkin_end: 'Your shift have successfully begun',
  not_checkin: 'You need to /checkin first',
  success_checkout_end: 'I hope you worked well today. Have a nice day',
  farewell_sticker: 'CAADAgADJgADwnaQBi5vOvKDgdd8Ag',
  photo_check_success: 'Good. Now i need your geolocation',
  photo_check_failure: "I don't see a photo here",
  geo_check_failure: "I don't see you in place"
}.freeze

TOKEN = ENV['BOT_TOKEN']

bot = Telegram::Bot::Client.new(TOKEN)
controller = WebhooksController
logger = Logger.new(STDOUT)

poller = Telegram::Bot::UpdatesPoller.new(bot, controller, logger: logger)
poller.start
