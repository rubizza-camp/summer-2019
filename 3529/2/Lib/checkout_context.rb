require 'fileutils'
require './Lib/Utiles/path_loader.rb'
require './Lib/Utiles/coordinates_handler.rb'
require './Lib/Utiles/utiles.rb'

module CheckoutContext
  include ImageFileWriter
  include CoordinatesHandler

  def checkout!(message = nil, *)
    @path_check = PathLoader.new(payload['from']['id'], payload['chat']['id'])
    checko(StatementFactory.build(message))
  end

  def checko(message)
    public_send("reply_to_#{message.class}".downcase.to_sym, @path_check, 'out')
    save_context :checkout!
  end
end
