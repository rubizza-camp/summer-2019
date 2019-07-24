require 'fileutils'
require './Lib/Utiles/path_loader.rb'
require './Lib/Utiles/coordinates_handler.rb'
require './Lib/Utiles/utiles.rb'

module CheckinContext
  include ImageFileWriter
  include CoordinatesHandler

  def checkin!(message = nil, *)
    @path_check = PathLoader.new(payload['from']['id'], payload['chat']['id'])
    checki(StatementFactory.build(message))
  end

  def checki(message)
    public_send("reply_to_#{message.class}".downcase.to_sym, @path_check, 'in')
    save_context :checkin!
  end
end
