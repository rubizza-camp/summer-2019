require './Lib/Utiles/selfie_handler.rb'
require './Lib/checkin_context.rb'
require './Lib/checkout_context.rb'

module ContextHandler
  include SelfieHandler
  include StartContext
  include CheckinContext
  include CheckoutContext

  def reply_to_selfie(_paths, in_or_out)
    if payload['text']
      respond_with :message, text: 'Send me your selfie, please'
    else
      selfie_handler(@path_check, in_or_out)
    end
  end
end
