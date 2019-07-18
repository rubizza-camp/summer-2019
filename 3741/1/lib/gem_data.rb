require 'open-uri'
require 'json'

# description params of gem and create comparator by count rank
class GemData
  def initialize(args)
    @attrs = args.slice(:name,
                        :used_by,
                        :contributors_count,
                        :issues_count,
                        :watcher_count,
                        :stars_count,
                        :forks_count)
  end

  def <=>(other)
    other.rank <=> rank
  end

  def rank
    [
      used_by,
      stars_count * 30,
      issues_count * -30,
      watcher_count * 20,
      forks_count * 30,
      contributors_count
    ].sum / 100
  end

  def name
    @attrs[:name]
  end

  def stars_count
    @attrs[:stars_count]
  end

  def issues_count
    @attrs[:issues_count]
  end

  def watcher_count
    @attrs[:watcher_count]
  end

  def forks_count
    @attrs[:forks_count]
  end

  def contributors_count
    @attrs[:contributors_count]
  end

  def used_by
    @attrs[:used_by]
  end
end
