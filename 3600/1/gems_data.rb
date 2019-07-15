require 'terminal-table'

# Write data to string
class GemsData
  attr_reader :obj

  def initialize(obj:)
    @obj = obj
  end

  def strings
    [obj.gem_name, "used by #{obj.used_by}", "watched by #{obj.watches}", "#{obj.stars} stars",
     "#{obj.forks} forks", "#{obj.contributors} contributors", "#{obj.issues} issues"]
  end
end

