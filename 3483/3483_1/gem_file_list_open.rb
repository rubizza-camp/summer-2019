require 'yaml'
#:reek:InstanceVariableAssumption
class GemFileListOpen
  def initialize(file_with_gems)
    @file_with_gems = file_with_gems
  end

  def fetch_gems_list
    open_yaml
    @array_with_gem.map! { |gem| gem.scan(/[a-z]+/).join('-') }
  end

  private

  def open_yaml
    @open_yaml ||= begin
      @array_with_gem = []
      gems = YAML.load_file(@file_with_gems.to_s)
      @array_with_gem << gems['gems'].split(' ')
      @array_with_gem.flatten!
    end
  end
end
