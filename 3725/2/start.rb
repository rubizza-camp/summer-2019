require 'telegram/bot'
require 'active_support/all'
require 'logger'
require 'redis-rails'
require 'yaml'
require 'open-uri'
require 'json'
require 'time'
require 'fileutils'
require 'active_support/time'

require_relative 'bot'
require_relative 'controllers/webhooks_controller'

token = '812391281:AAGbnwP8CdHvhZV5_rNSw9ryuRRbEUroLno'

controller = Bot.new(token)
controller.call
