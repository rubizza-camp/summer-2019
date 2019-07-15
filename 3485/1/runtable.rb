require_relative 'table.rb'
require_relative 'parse_gem_stats.rb'
require_relative 'top_gems.rb'

class RunTable
  class << self
    def run
      TopGems.new
    end
  end
end

RunTable.run
