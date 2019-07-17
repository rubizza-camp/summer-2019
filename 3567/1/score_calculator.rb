class ScoreCalculator
  attr_reader :gem_data

  def initialize(gem_data:)
    @gem_data = gem_data
  end

  def call
    gem_data[:Used_by] + gem_data[:Watch] +
      gem_data[:Contributors] / 2 + gem_data[:Issues] / 2
  end
end
