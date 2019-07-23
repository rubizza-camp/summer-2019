module TextFileWriter
  def write_text_file(path_geo)
    File.open(path_geo, 'w') do |file|
      file.write payload['text']
    end
  end
end
