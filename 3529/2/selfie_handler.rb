require_relative 'image_file_writer'

module SelfieHandler
  include ImageFileWriter

  def selfie_handler(path, in_or_out)
    path_img = path.create_directory(in_or_out, "#{payload['from']['username']}.jpg")
    write_image_file(path_img)
    respond_with :message, text: 'Then send me your coordinates, pleas'
  end
end
