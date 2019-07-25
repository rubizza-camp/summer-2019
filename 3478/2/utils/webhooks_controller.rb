require_relative 'file_manager.rb'
require_rel '/command/'

class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_250_000 }
  include Telegram::Bot::UpdatesController::MessageContext

  def initialize(*)
    super
    @redis = Redis.new
  end

  def callback_query(data)
    delete(data)
  end

  include StartCommand
  include Unlink
  include CheckoutCommand
  include CheckinCommand
end
