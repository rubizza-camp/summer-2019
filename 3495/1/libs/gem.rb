# This class collect all info about gem

class MyGem
  def initialize(gem_name, statistic)
    @gem_name = gem_name
    @statistic = statistic
    @coolness = coolness_calc
  end

  def insert_params
    [@gem_name, *@statistic.values, @coolness]
  end

  def coolness_calc
    @statistic[:watch] + @statistic[:stars] + @statistic[:forks] + @statistic[:contributors] +
      @statistic[:used_by] / (@statistic[:issues] + 1)
  end
end
