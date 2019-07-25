require 'redis'
require 'telegram/bot'
require 'logger'
require 'yaml'
require 'active_support/all'
require 'ohm'
require 'date'
require 'fileutils'
require 'i18n'

require_relative 'lib/model/user_model.rb'
require_relative 'lib/command/bot_start_commands.rb'
require_relative 'lib/command/bot_checkin_commands.rb'
require_relative 'lib/command/bot_checkout_commands.rb'
require_relative 'bot.rb'
require_relative 'lib/controller/webhooks_controller.rb'
require_relative 'lib/helper/dir_manager.rb'
require_relative 'lib/helper/geolocation_uploader.rb'
require_relative 'lib/helper/photo_uploader.rb'

STATUS = [true, false].freeze

I18n.load_path << Dir[File.expand_path('data/locales') + '/*.yml']
I18n.locale = :en
Bot.new(ENV['TG_TOKEN']).run
