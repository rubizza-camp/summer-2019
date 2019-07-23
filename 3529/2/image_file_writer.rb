require_relative 'image_loader'

module ImageFileWriter
  include ImageLoader
  def write_image_file(path_img)
    Kernel.open(path_img, 'wb') do |file|
      file << Kernel.open(load_image).read
    end
  end
end
