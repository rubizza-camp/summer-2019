require './Lib/Utiles/image_loader.rb'

module ImageFileWriter
  include ImageLoader

  def write_image_file(path_img)
    Kernel.open(path_img, 'wb') do |file|
      file << Kernel.open(load_image).read
    end
  end
end
