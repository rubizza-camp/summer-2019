require_relative 'text_file_writer'

module CoordinatesHandler
  include TextFileWriter

  def coord_handle(path, in_or_out)
    path_geo = path.load_path(in_or_out) + "#{payload['from']['username']}.txt"
    path.create_directory(path_geo)
    write_text_file(path_geo)
    respond_with :message, text: 'Have fun and good luck!!!'
  end
end
