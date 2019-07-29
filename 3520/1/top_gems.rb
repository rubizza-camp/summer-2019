require './lib/gems_data.rb'

class TopGems
  class << self
    def run
      GemsData.new
    end
  end
end

TopGems.run
