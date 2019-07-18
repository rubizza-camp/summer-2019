class GemFetcher
  def self.read_file_of_gems
    YAML.safe_load(File.read("#{Dir.pwd}/gems.yaml"))['gems'].map { |name| Gemy.new(name) }
  end
end
