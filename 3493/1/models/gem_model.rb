module Models
  # :reek:InstanceVariableAssumption
  # :reek:Attribute
  # :reek:TooManyInstanceVariables:
  class GemModel
    attr_accessor :url, :name, :count_contributors, :count_used_by
    attr_reader :url, :name, :count_watched, :count_stars, :count_forks, :count_issues, :count_used_by

    def initialize(name)
      @name = name
    end

    def install_fields(args)
      @count_watched = args[0]
      @count_stars = args[1]
      @count_forks = args[2]
      @count_issues = args[3]
      @count_contributors = args[4]
    end

    def fields
      {name: name,count_used_by: count_used_by.to_i,count_watched: count_watched.to_i, count_stars: count_stars.to_i,
       count_forks: count_forks.to_i, count_contributors: count_contributors.to_i, count_issues: count_issues.to_i}
    end

    def strings
      [name, "used by #{count_used_by}", "watched by #{count_watched}", "#{count_stars} stars",
       "#{count_forks} forks", "#{count_contributors} contibutors", "#{count_issues} issues"]
    end
  end
end
