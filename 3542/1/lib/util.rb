require 'yaml'

module Util
  class YAML
    def self.parse(path)
      Psych.safe_load FileManager.open path
    end
  end

  class FileManager
    def self.open(path)
      File.open File.expand_path(path)
    end
  end
end
