class NameToLinkTransformer
  attr_reader :valid, :link
  def initialize(name)
    @name = name
    @valid = false
    @link = ''
    github_link
  end

  def github_link
    doc = Nokogiri::HTML(URI.open("https://rubygems.org/gems/#{@name}"))
    all_links = doc.css('a#code').map { |link| link.attribute('href').to_s }
    @valid = !all_links.empty?
    @link = all_links.first if @valid
  end
end
