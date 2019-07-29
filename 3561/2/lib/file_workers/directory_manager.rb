class DirectoryManager
  def self.create_directory(directory_name)
    FileUtils.mkdir_p directory_name
  end
end
