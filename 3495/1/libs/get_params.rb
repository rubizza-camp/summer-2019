# This class getting gem params
class ParamsGetter
  attr_reader :params
  def initialize(gem_url)
    @gem_url = gem_url
    @html = Nokogiri::HTML(URI.parse(gem_url).open)
    @params = params_get
  end

  # rubocop: disable Metrics/AbcSize
  #:reek:TooManyStatements:
  #:reek:DuplicateMethodCall:
  def params_get
    watch = @html.css('ul.pagehead-actions a')[1].text.delete('^0-9').to_i
    stars = @html.css('ul.pagehead-actions a')[3].text.delete('^0-9').to_i
    forks = @html.css('ul.pagehead-actions a')[5].text.delete('^0-9').to_i
    issues = @html.css('nav.hx_reponav span')[4].text.to_i
    contributors = @html.css('ul.numbers-summary a')[3].text.delete('^0-9').to_i
    @gem_url += '/network/dependents'
    @html = Nokogiri::HTML(URI.parse(@gem_url).open)
    used_by = @html.css('div.table-list-header-toggle a')[0].text.delete('^0-9').to_i
    [watch, stars, forks, issues, contributors, used_by]
  end
  # rubocop: enable Metrics/AbcSize
end
