require 'fileutils'
require_relative 'path_loader'
require_relative 'coordinates_handler'
require_relative 'selfie_handler'

module CheckinContext
  include ImageFileWriter
  include CoordinatesHandler
  include SelfieHandler

  def checkin!(message = nil, *)
    @path_check = PathLoader.new(payload)
    save_context :checkin!
    if message
      coord_handle(@path_check, 'in')
    elsif payload['text']
      respond_with :message, text: 'Send me your selfie, please'
    else
      selfie_handler(@path_check, 'in')
    end
  end
end
