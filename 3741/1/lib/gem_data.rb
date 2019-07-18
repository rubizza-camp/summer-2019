require 'open-uri'
require 'json'

# description params of gem and create comparator by count rank
class GemData
  attr_reader :name,
              :used_by,
              :contributors_count,
              :issues_count,
              :watcher_count,
              :stars_count,
              :forks_count,
              :rank

  def initialize(args)
    @name = args[:name]
    @forks_count = args[:forks_count]
    @issues_count = args[:issues_count]
    @contributors_count = args[:contributors_count]
    @watcher_count = args[:watcher_count]
    @used_by = args[:used_by]
    @stars_count = args[:stars_count]
    @rank = count_rank
  end

  def <=>(other)
    rank <=> other.rank
  end

  private

  def count_rank
    [
      used_by,
      stars_count * 30,
      issues_count * -30,
      watcher_count * 20,
      forks_count * 30,
      contributors_count
    ].sum / 100
  end
end
