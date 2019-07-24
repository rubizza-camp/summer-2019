class DirCreator
  def call; end

  def self.call(dir_path)
    FileUtils.mkdir_p dir_path
  end
end
