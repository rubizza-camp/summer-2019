require 'telegram/bot'
require 'redis'
require 'logger'
require 'active_support/all'
require 'net/http'
require 'date'
require 'yaml'
require 'i18n'
require_relative 'helpers/command_helper'
require_relative 'helpers/context_messages'
require_relative 'helpers/locale_chooser'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'webhooks_controller'
require_relative 'bot'

I18n.load_path << 'data/locales.yml'
I18n.default_locale = :ru
bot = Bot.new(ENV['TOKEN'])
bot.call
