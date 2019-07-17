require 'yaml'

module Util
  module Parse
    class HTML
      def self.parse(url)
        Nokogiri::HTML(HTTParty.get(url))
      end
    end

    class YAML
      def self.parse(path)
        Psych.safe_load FileManager.open path
      end
    end
  end

  class FileManager
    def self.open(path)
      File.open File.expand_path(path)
    end
  end
end
