require 'dotenv'
require 'telegram/bot'
require 'logger'
require 'redis-rails'
require 'yaml'
require 'active_support/all'
require 'open-uri'
require 'json'
require 'time'
require 'fileutils'
require_relative 'commands/start.rb'
require_relative 'commands/checkin.rb'
require_relative 'commands/checkout.rb'
require_relative 'dop_files/receive_photo_and_location'
require_relative 'dop_files/file_manager'
require_relative 'dop_files/download_photo'
require_relative 'dop_files/bot.rb'
require_relative 'dop_files/webhooks_controller'

Dotenv.load
controller = Bot.new(ENV['TELEGRAM_TOKEN'])
controller.call
