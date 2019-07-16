require_relative 'ruby_gems_parse.rb'
require_relative 'github_parser.rb'

# Class for calling RubyGemsParser and GithubParser,
# getting all information about gems
# and counting rating for gems
class GemInfo
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def call
    puts gem_name
    github_link = RubyGemsParse.new.call(gem_name)
    return {} unless github_link

    info = GithubParser.new(github_link).parse
    add_rating(info)
  end

  private

  def add_rating(info)
    rating =
      info.slice(:stars, :watches, :forks, :contributors).values.sum
    info[:rating] = rating - info[:issues]
    info
  end
end
