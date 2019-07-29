require_relative 'modules/start_command'
require_relative 'camp_allowed_numbers'
require_relative 'modules/checkin_command'
require_relative 'modules/checkout_module'
require_relative 'modules/check_photo'
require_relative 'modules/geo_checker'
require_relative 'path_creator'

class WebhooksController < Telegram::Bot::UpdatesController
  attr_reader :list_of_numbers

  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include Checkin
  include Checkout
  include CheckPhoto
  include GeoChecker

  def initialize(*)
    super
    Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.months }
  end

  def say_to_user_chat(msg)
    respond_with :message, text: msg
  end

  def number_registered?
    session.key?(:number)
  end

  def logged_in?
    session[:status] == :in
  end
end
