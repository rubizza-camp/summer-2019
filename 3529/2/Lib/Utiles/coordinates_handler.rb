require './Lib/Utiles/text_file_writer.rb'

module CoordinatesHandler
  include TextFileWriter

  def reply_to_coordinates(path, in_or_out)
    path_coord = path.create_directory(in_or_out, "#{payload['from']['username']}.txt")
    write_text_file(path_coord)
    respond_with :message, text: 'Have fun and good luck!!!'
  end
end
