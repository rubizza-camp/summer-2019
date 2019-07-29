require 'i18n'
Dir[File.join('./modules', '*.rb')].each { |file| require_relative file }

I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
I18n.default_locale = :en

class WebhooksController < Telegram::Bot::UpdatesController
  Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 2_592_000 }

  include Telegram::Bot::UpdatesController::MessageContext
  include StartCommand
  include CheckinCommand
  include CheckoutCommand
  include DeleteCommand
  include PhotoDownloader
  include GeoDownloader
  include RedisHelper
end
