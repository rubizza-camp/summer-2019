require 'telegram/bot'
require 'redis'
require 'fileutils'
require 'date'
require 'dotenv'
require 'i18n'

Dir[File.join(__dir__, 'command', '*_command.rb')].each { |file| require file }
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'helper', '*.rb')].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext

  I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']

  include Helper
  include MessageRespond
  include StartCommand
  include DeleteCommand
  include CheckinCommand
  include CheckoutCommand
  include EndCommand
end
