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
    github_in_code_link(doc)
    github_in_home_link(doc) unless @valid
  end

  def github_in_code_link(page)
    all_links = page.css('a#code').map { |link| link.attribute('href').to_s }
    @valid = !all_links.empty?
    @link = all_links.first
  end

  def github_in_home_link(page)
    alternative = page.css('a#home').map { |link| link.attribute('href').to_s }.first
    @valid = alternative.include? 'github'.freeze
    @link = alternative
  end
end
