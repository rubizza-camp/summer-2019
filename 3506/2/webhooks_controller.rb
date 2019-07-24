require 'pry'
require 'ohm'
require 'haversine'

require_relative 'user_upload'
require_relative 'start'
require_relative 'checkin'
require_relative 'checkout'
require_relative 'location'

class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
  include Start
  include CheckIn
  include CheckOut

  self.session_store = :file_store, '.cache'

  def user
    @user = User.with(:telegram_id, from['id'])
  end
end
