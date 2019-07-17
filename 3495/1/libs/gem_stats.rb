# This class collects all info about gem

class GemStats
  attr_reader :gem_name, :statistic, :coolness

  def call(gem_name, statistic)
    @gem_name = gem_name
    @statistic = statistic
    @coolness = calc_coolness
    self
  end

  def self.call(gem_name, statistic)
    new.call(gem_name, statistic)
  end

  def insert_params
    [gem_name, *statistic.values, coolness]
  end

  def calc_coolness
    statistic[:watch] + statistic[:stars] + statistic[:forks] + statistic[:contributors] +
      used_by_divide_by_issues
  end

  def used_by_divide_by_issues
    statistic[:used_by] / (statistic[:issues] + 1)
  end
end
