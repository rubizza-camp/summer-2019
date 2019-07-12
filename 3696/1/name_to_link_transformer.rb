# frozen_string_literal: true

class NameToLinkTransformer
  def initialize(name)
    @name = name
    @doc ||= Nokogiri::HTML(URI.open("https://rubygems.org/gems/#{@name}"))
  end

  def link
    github_in_code_link || github_in_home_link || 'no-link'
  end

  private

  def github_in_code_link
    @doc.css('a#code').map { |link| link.attribute('href').to_s }.first
  end

  def github_in_home_link
    alternative = @doc.css('a#home').map { |link| link.attribute('href').to_s }.first
    return alternative if alternative.include?('github')
  end
end
