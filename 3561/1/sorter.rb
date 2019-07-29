class Sorter
  def self.sort(gems)
    my_score(gems)
    gems.sort_by { |gem| gem[:my_score] }.reverse
  end

  def self.add_my_score(gems)
    gems.each do |gem|
      gem[:my_score] = gem[:used_by] + gem[:watchers] +
                       gem[:stars] + gem[:forks] +
                       gem[:contributors] / 2 + gem[:issues] / 2
    end
  end
end
