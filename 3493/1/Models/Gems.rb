class Gems
  attr_reader :url
  attr_writer :url, :name, :count_contributors, :count_used_by

  def initialize(name)
    @name = name
  end

  def set_fields(args)
    @count_watched = args[0]
    @count_stars = args[1]
    @count_forks = args[2]
    @count_issues = args[3]
    @count_contributors = args[4]
  end

  def get_fields
    [@name,"used by #{@count_used_by}", "watched by #{@count_watched}","#{@count_stars} stars",
       "#{@count_forks} forks","#{@count_contributors} contibutors", "#{@count_issues} issues"]
  end
end