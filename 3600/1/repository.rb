# Save gem's data from repos
class Repository
  attr_reader :gem_name, :used_by, :watches, :stars, :forks, :contributors, :issues

  def initialize(opts = {})
    opts.each_pair do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end
end
