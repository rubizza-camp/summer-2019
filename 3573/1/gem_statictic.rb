class RubyGemStatistic
  attr_reader :gem_name, :used_by, :watches, :stars, :forks, :contributors, :issues

  def initialize(gem_name:, used_by:, watches:, stars:, forks:, contributors:, issues:)
    @gem_name = gem_name
    @used_by = used_by
    @watches = watches
    @stars = stars
    @forks = forks
    @contributors = contributors
    @issues = issues
  end

  # def to_s
  #   "#{gem_name} | used by #{used_by} | watched by #{watches} |  #{stars} stars | #{forks} forks | #{contributors} contributors | #{issues} issues |"
  # end

  def strings
    [gem_name, "used by #{used_by}", "watched by #{watches}", "#{stars} stars",
     "#{forks} forks", "#{contributors} contributors", "#{issues} issues"]
  end
end


