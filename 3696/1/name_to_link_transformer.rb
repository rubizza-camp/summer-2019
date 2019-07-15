class NameToLinkTransformer
  def initialize(name)
    @name = name
  end

  def link
    github_in_code_link || github_in_home_link || 'no-link'
  end

  private

  attr_reader :name

  # :reek:UncommunicativeVariableName
  def doc
    @doc ||= Nokogiri::HTML(URI.open("https://rubygems.org/gems/#{@name}"))
  rescue OpenURI::HTTPError => e
    puts "#{name} #{I18n.t('not_a_gem')}" if e.message == '404 Not Found'
    raise ParseException.new, name
  end

  def github_in_code_link
    doc.css('a#code').first.attribute('href').to_s unless doc.css('a#code').empty?
  end

  def github_in_home_link
    doc.css('a#home').empty? ? return : alternative = doc.css('a#home').first.attribute('href').to_s

    alternative if alternative.include?('github')
  end
end
