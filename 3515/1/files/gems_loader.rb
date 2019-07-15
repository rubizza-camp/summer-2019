class GemsLoaderFromFile
  attr_reader :gems_from_file
  attr_reader :length

  def initialize(path_to_yml = 'gems.yml')
    @gems_from_file = YAML.load_file(path_to_yml).values.first
    @length = @gems_from_file.length
  end
end
