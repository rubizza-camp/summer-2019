module Util
  module Parse
    class HTML
      def self.parse(url)
        Nokogiri::HTML(HTTParty.get(url))
      end
    end

    class YAML
      def self.parse(path)
        YAML.safe_load File.open_file path
      end
    end
  end

  class File
    def self.open_file(path)
      File.open File.expand_path(path)
    end
  end
end
