require 'fileutils'
require_relative 'path_loader'
require_relative 'coordinates_handler'
require_relative 'selfie_handler'

module CheckoutContext
  include ImageFileWriter
  include CoordinatesHandler
  include SelfieHandler

  def checkout!(message = nil, *)
    save_context :checkout!
    if message
      coord_handle(@@path_checkout, 'out')
    elsif payload['text']
      respond_with :message, text: 'Send me your selfie, please'
    else
      @@path_checkout = PathLoader.new(payload)
      selfie_handler(@@path_checkout, 'out')
    end
  end
end
