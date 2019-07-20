require_relative 'table.rb'
require_relative 'parse_gem_stats.rb'
require_relative 'topgems.rb'

class TopGems
  class << self
    def run
      ShowTopgemsTable.new
    end
  end
end

TopGems.run
