class NameToLinkTransformer
  def initialize(name)
    @name = name
  end

  def link
    github_in_code_link || github_in_home_link || 'no-link'
  end

  private

  def doc
    @doc ||= Nokogiri::HTML(URI.open("https://rubygems.org/gems/#{@name}"))
  end

  def github_in_code_link
    doc.css('a#code').first.attribute('href').to_s unless doc.css('a#code').empty?
  end

  def github_in_home_link
    doc.css('a#home').empty? ? return : alternative = doc.css('a#home').first.attribute('href').to_s

    alternative if alternative.include?('github')
  end
end
