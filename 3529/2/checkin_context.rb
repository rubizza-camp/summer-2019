require 'fileutils'
require_relative 'path_loader'
require_relative 'coordinates_handler'
require_relative 'selfie_handler'

module CheckinContext
  include ImageFileWriter
  include CoordinatesHandler
  include SelfieHandler

  def checkin!(message = nil, *)
    save_context :checkin!
    @path_check = PathLoader.new(payload)
    new = message
    if new
      coord_handle(@path_check, 'in')
    else
      reply
    end
  end

  private

  def reply
    if payload['text']
      respond_with :message, text: 'Send me your selfie, please'
    else
      selfie_handler(@path_check, 'in')
    end
  end
end
