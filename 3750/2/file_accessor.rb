class FileAccessor
  def self.personal_numbers
    YAML.safe_load(File.read("#{Dir.pwd}/personal_numbers.yaml")).split ' '
  end
end
