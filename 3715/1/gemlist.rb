require_relative 'file_interaction.rb'
require_relative 'rubygem.rb'

# Making a list of gems
class GemList
  def self.make_gemlist
    Files.new.name_gem.map { |title| RubyGem.new(title) }
  end
end
