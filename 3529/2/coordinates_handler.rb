require_relative 'text_file_writer'

module CoordinatesHandler
  include TextFileWriter

  def coord_handle(path, in_or_out)
    path_txt = path.create_directory(in_or_out, "#{payload['from']['username']}.txt")
    write_text_file(path_txt)
    respond_with :message, text: 'Have fun and good luck!!!'
  end
end
