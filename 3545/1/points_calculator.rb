class PointsCalculator
  def initialize(gem_parameters)
    @gem_parameters = gem_parameters
  end

  def stars
    @gem_parameters[1] * 20
  end

  def watchers
    @gem_parameters[2] * 200
  end

  def forks
    @gem_parameters[3] * 50
  end

  def contributors
    @gem_parameters[4] * 300
  end

  def issues
    @gem_parameters[5] * -2
  end

  def users
    @gem_parameters[6] * 2
  end

  def calculate_all
    [stars, watchers, forks, contributors, issues, users, contributors].sum
  end
end
