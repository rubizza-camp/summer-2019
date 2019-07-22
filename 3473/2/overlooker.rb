# frozen_string_literal: true

require 'telegram/bot'
require 'logger'
require 'redis'
require 'redis-store'
require 'redis-rails'
require 'yaml'
require_relative './commands/start_command'
require_relative './commands/login_command'
require_relative './commands/check_commands'
require_relative './commands/logout_command'
require_relative './commands/static_util'

class WebhooksController < Telegram::Bot::UpdatesController
  extend StaticUtil

  include StartCommand
  include LoginCommand
  include CheckCommands
  include LogoutCommand
  include Telegram::Bot::UpdatesController::MessageContext
end

