# This class loads gem parameters

class StatsLoader
  attr_reader :stats, :html

  def initialize(gem_url)
    @gem_url = gem_url
    @html = Nokogiri::HTML(URI.parse(gem_url).open)
    @stats = statistic
  end

  def statistic
    { watch: watch_stat, stars: stars_stat, forks: forks_stat, issues: issues_stat,
      contributors: contributors_stat, used_by: used_by_stat }
  end

  def watch_stat
    html.css('ul.pagehead-actions a')[1].text.delete('^0-9').to_i
  end

  def stars_stat
    html.css('ul.pagehead-actions a')[3].text.delete('^0-9').to_i
  end

  def forks_stat
    html.css('ul.pagehead-actions a')[3].text.delete('^0-9').to_i
  end

  def issues_stat
    html.css('nav.hx_reponav span')[4].text.to_i
  end

  def contributors_stat
    html.css('ul.numbers-summary a')[3].text.delete('^0-9').to_i
  end

  def used_by_stat
    @gem_url += '/network/dependents'
    html = Nokogiri::HTML(URI.parse(@gem_url).open)
    html.css('div.table-list-header-toggle a')[0].text.delete('^0-9').to_i
  end
end
