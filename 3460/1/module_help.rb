# module Helper
module Helper 
    def refactor(gems)
      gems.map! do |gem|
        gem.delete('-')
      end
    end
end