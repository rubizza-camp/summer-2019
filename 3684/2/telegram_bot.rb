require 'telegram/bot'
require 'redis'
require 'logger'
require 'active_support/all'
require 'net/http'
require 'date'
require 'yaml'
require_relative 'commands/helper'
require_relative 'commands/context_messages'
require_relative 'commands/command_start'
require_relative 'commands/command_checkin'
require_relative 'commands/command_checkout'
require_relative 'webhooks'
require_relative 'bot_caller'

bot = Bot.new(ENV['TOKEN'])
bot.call
