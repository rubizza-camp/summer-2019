require 'active_support/all'
require 'telegram/bot'
require 'logger'
require 'redis'
require 'i18n'
require_relative 'lib/commands/start.rb'
require_relative 'lib/commands/checkin.rb'
require_relative 'lib/commands/checkout.rb'
require_relative 'lib/student_list_fetcher.rb'
require_relative 'lib/controller/webhooks_controller.rb'
require_relative 'lib/helpers/base_command_helpers.rb'
require_relative 'lib/helpers/photo.rb'
require_relative 'lib/helpers/location.rb'

STUDENT_LIST = StudentListFetcher.read_from_file
REDIS = Redis.new

I18n.load_path << Dir[File.expand_path('data/locales') + '/*.yml']
I18n.default_locale = :ru

bot = Telegram::Bot::Client.new(ENV['TOKEN'])

# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
