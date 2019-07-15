class Util
  def self.parse_html(url)
    Nokogiri::HTML(HTTParty.get(url))
  end

  def self.parse_file(path)
    YAML.safe_load open_file path
  end

  def self.open_file(path)
    File.open File.expand_path(path)
  end
end
