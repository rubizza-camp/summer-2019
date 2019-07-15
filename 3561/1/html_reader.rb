require 'yaml'
require 'io/console'

class HtmlReader
  def self.read_html(hash_of_gem)
    parametrs = %i[watchers issues used_by contributors]
    full_name = hash_of_gem[:full_name]
    something(parametrs, full_name, hash_of_gem)
  end

  def self.something(parametrs, full_name, hash_of_gem)
    parametrs.each do |parameter|
      case parameter
      when :watchers, :issues, :used_by
        url = "https://github.com/#{full_name}/network/dependents"
      when :contributors
        url = "https://github.com/#{full_name}"
      end
      hash_of_gem[parameter] = Nokogiri::HTML(URI.open(url))
    end
    hash_of_gem
  end
end
