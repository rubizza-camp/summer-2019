# This class getting gem params
class ParamsGetter
  attr_reader :params

  def initialize(gem_url)
    @gem_url = gem_url
    @html = Nokogiri::HTML(URI.parse(gem_url).open)
    @params = params_get
  end

  def params_get
    { watch: watch_get, stars: stars_get, forks: forks_get, issues: issues_get,
      contributors: contributors_get, used_by: used_by_get }
  end

  def watch_get
    @html.css('ul.pagehead-actions a')[1].text.delete('^0-9').to_i
  end

  def stars_get
    @html.css('ul.pagehead-actions a')[3].text.delete('^0-9').to_i
  end

  def forks_get
    @html.css('ul.pagehead-actions a')[3].text.delete('^0-9').to_i
  end

  def issues_get
    @html.css('nav.hx_reponav span')[4].text.to_i
  end

  def contributors_get
    @html.css('ul.numbers-summary a')[3].text.delete('^0-9').to_i
  end

  def used_by_get
    @gem_url += '/network/dependents'
    @html = Nokogiri::HTML(URI.parse(@gem_url).open)
    @html.css('div.table-list-header-toggle a')[0].text.delete('^0-9').to_i
  end
end
