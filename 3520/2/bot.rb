require 'telegram/bot'
require 'logger'
require 'redis-activesupport'
require './commands/start'
require './commands/registration'
require './commands/logout'
require './commands/checkin'
require './commands/validation'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session # use_session!
  include Telegram::Bot::UpdatesController::MessageContext

  self.session_store = :redis_store

  include StartCommand
  include RegistrationCommand
  include LogoutCommand
  include CheckinCommand
  include Validation
  # def start!(*)
  #   if registered?
  #     respond_with :message, text: "Greetings #{session[:number]}"
  #   else
  #     respond_with :message, text: 'Hello! What is your number?'
  #     save_context :registration!
  #   end
  # end

  # def logout!(*)
  #   respond_with :message, text: "Goodbye, #{session[:number]}!" if registered?
  #   session.destroy
  # end

  # def registered?
  #   session[:number]
  # end

  # def registration!(number)
  #   if check_number!(number)
  #     respond_with :message, text: "I don't know you, boy. So try again or go away."
  #     save_context :registration!
  #   else
  #     respond_with :message, text: 'Greetings, young fellow.'
  #     session[:number] = number
  #   end
  # end

  # This method smells of :reek:UtilityFunction and :reek:NilCheck
  # def check_number!(number)
  #   File.open('data/numbers.txt').detect { |known| known.chop == number.to_s }.nil?
  # end

  # def checkin!(*)
  #   respond_with :message, text: 'Send me a selfire.'
  # end
end

# system ('redis-server')

TOKEN = ENV['CAMP_BOT_TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)
# Telegram::Bot::UpdatesController.session_store = :redis_store, {expires_in: 1.month}
# poller-mode
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
