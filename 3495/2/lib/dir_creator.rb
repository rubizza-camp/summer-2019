class DirCreator
  def self.dir_create(dir_path)
    FileUtils.mkdir_p dir_path
  end
end
