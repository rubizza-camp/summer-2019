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
    @path_check = PathLoader.new(payload)
    if message
      coord_handle(@path_check, 'out')
    elsif payload['text']
      respond_with :message, text: 'Send me your selfie, please'
    else
      selfie_handler(@path_check, 'out')
    end
  end
end
