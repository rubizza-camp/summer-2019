require 'telegram/bot'
require 'active_support/all'
require 'logger'
require 'redis-rails'
require 'yaml'
require 'open-uri'
require 'json'
require 'time'
require 'ohm'
require 'fileutils'
require 'active_support/time'
require_relative 'user'
require_relative 'bot'
require_relative 'controllers/webhooks_controller'

token = '812391281:AAGbnwP8CdHvhZV5_rNSw9ryuRRbEUroLno'
Ohm.redis = Redic.new('redis://127.0.0.1:6379')
controller = Bot.new(token)
controller.call
