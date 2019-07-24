require './Lib/Utiles/image_file_writer.rb'

module SelfieHandler
  include ImageFileWriter

  def selfie_handler(path_loader, in_or_out)
    path_img = path_loader.create_directory(in_or_out, "#{payload['from']['username']}.jpg")
    write_image_file(path_img)
    respond_with :message, text: 'Then send me your coordinates, pleas'
  end
end
