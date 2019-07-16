# This class collects all info about gem

class MyGem
  attr_reader :gem_name, :statistic, :coolness

  def initialize(gem_name, statistic)
    @gem_name = gem_name
    call(statistic)
  end

  def call(statistic)
    @statistic = statistic
    @coolness = coolness_calc
  end

  def insert_params
    [gem_name, *statistic.values, coolness]
  end

  def coolness_calc
    statistic[:watch] + statistic[:stars] + statistic[:forks] + statistic[:contributors] +
      used_by_divide_by_issues
  end

  def used_by_divide_by_issues
    statistic[:used_by] / (statistic[:issues] + 1)
  end
end
