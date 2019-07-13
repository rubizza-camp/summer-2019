module FileManager
  private

  def parse_file(path)
    YAML.safe_load file path
  end

  def file(path)
    File.open File.expand_path(path)
  end
end
