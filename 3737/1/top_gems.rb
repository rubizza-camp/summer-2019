require_relative 'gems_collection.rb'
require_relative 'options.rb'
require_relative 'table.rb'

# class that show gems with their's stats
class TopGems
  def run
    option = Options.new.options_for_gems
    gems = GemsCollection.new.gems_list(option)
    puts Table.new.show(gems)
  end
end

TopGems.new.run
