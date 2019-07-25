require 'redis'
require 'fileutils'
require 'date'
require 'dotenv'
require 'i18n'

Dir[File.join(__dir__, 'commands', '*_command.rb')].each { |file| require file }
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'helpers', '*.rb')].each { |file| require file }

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext

  I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']

  include I18n
  include Helper
  include SessionsHelper
  include StartCommand
  include DeleteCommand
  include CheckinCommand
  include CheckoutCommand
end
