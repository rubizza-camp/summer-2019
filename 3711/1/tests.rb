require_relative 'parser/git_hub'

def test_all
  gem_names = %w[rails sinatra rspec]
  gem_arr = gem_names.map { |gem_name| Parser::GitHub.new(gem_name).parse }
  gem_arr.each { |gem| puts gem }
end

test_all
