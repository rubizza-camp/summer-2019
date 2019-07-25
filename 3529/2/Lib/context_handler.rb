require 'fileutils'

Dir[File.dirname(__FILE__) + '/Utiles/*.rb'].each { |file| require file }

module ContextHandler
  include ImageFileWriter
  include TextFileWriter

  def start!(message = nil, *)
    save_context :start!
    if message
      answer = response(message)
      respond_with :message, text: answer
    else
      respond_with :message, text: 'Hello, rook! Enter your camp number'
    end
  end

  def response(message)
    number_checker = NumberChecker.new('Data/camp_participants.yaml')
    number_checker.handle_number(message, payload)
  end

  def checkout!(message = nil, *)
    @path_check = PathLoader.new(payload['from']['id'])
    checko(StatementFactory.build(message))
  end

  def checko(message)
    public_send("reply_to_#{message.class}".downcase.to_sym, @path_check, 'out')
    save_context :checkout!
  end

  def checkin!(message = nil, *)
    @path_check = PathLoader.new(payload['from']['id'])
    checki(StatementFactory.build(message))
  end

  def checki(message)
    public_send("reply_to_#{message.class}".downcase.to_sym, @path_check, 'in')
    save_context :checkin!
  end

  def reply_to_selfie(path, in_or_out)
    if payload['text']
      respond_with :message, text: 'Send me your selfie, please'
    else
      path_img = path.create_directory(in_or_out, "#{payload['from']['username']}.jpg")
      write_image_file(path_img)
      respond_with :message, text: 'Then send me your coordinates, pleas'
    end
  end

  def reply_to_coordinates(path, in_or_out)
    path_coord = path.create_directory(in_or_out, "#{payload['from']['username']}.txt")
    write_text_file(path_coord)
    respond_with :message, text: 'Have fun and good luck!!!'
  end
end
