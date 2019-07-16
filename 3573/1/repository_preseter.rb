# Task: save in strings
class RepositoryPreseter
  attr_reader :obj

  def initialize(obj:)
    @obj = obj
  end

  def strings
    [obj.gem_name, obj.used_by, obj.watches, obj.stars,
     obj.forks, obj.contributors, obj.issues]
  end
end
