require 'telegram/bot'
require 'logger'
require 'active_support/all'
require 'redis'
require 'pry'
require 'ohm'
require 'fileutils'
require 'date'
require 'dotenv/load'

require_relative 'lib/models/user'

require_relative 'lib/commands/start_command.rb'
require_relative 'lib/commands/check_command.rb'

require_relative 'lib/bot.rb'
require_relative 'lib/controllers/webhooks_controller.rb'

require_relative 'lib/file_workers/directory_manager.rb'
require_relative 'lib/file_workers/file_manager.rb'

require_relative 'lib/helpers/geo_manager.rb'
require_relative 'lib/helpers/photo_manager.rb'

controller = Bot.new(ENV['TOKEN'])
controller.start
