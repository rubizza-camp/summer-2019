class GemParamGetter
  attr_reader :contributors
  attr_reader :forks
  attr_reader :issues
  attr_reader :stars
  attr_reader :used_by
  attr_reader :watched_by
  attr_reader :gem_url
  attr_reader :gem_name
  attr_reader :params

  def define_variables(gem_url, gem_name)
    @gem_name = gem_name
    @gem_url = gem_url
    @params = return_params_array
  end

  private

  def return_params_array
    [gem_name, parse_watched_by, parse_stars, parse_forks, parse_issues,
     parse_contributors, parse_used_by, gem_rate_count]
  end

  def html_page(gem_url)
    @html_page ||= Mechanize.new.get(gem_url)
  end

  def html_page_parse_contributos(gem_url)
    Mechanize.new.get(gem_url + '/contributors_size')
  end

  def html_page_used_by(gem_url)
    Mechanize.new.get(gem_url + '/network/dependents')
  end

  def parse_watched_by
    html_page(gem_url).css('ul.pagehead-actions a')[1].text.delete('^0-9').to_i
  end

  def parse_stars
    html_page(gem_url).css('ul.pagehead-actions a')[3].text.delete('^0-9').to_i
  end

  def parse_forks
    html_page(gem_url).css('ul.pagehead-actions a')[5].text.delete('^0-9').to_i
  end

  def parse_issues
    html_page(gem_url).css('nav.hx_reponav span')[4].text.to_i
  end

  def parse_contributors
    html_page_parse_contributos(gem_url).css('span.text-emphasized').text.delete('^0-9').to_i
  end

  def parse_used_by
    html_page_used_by(gem_url).css('div.table-list-header-toggle a')[0]
                              .text.delete('^0-9').to_i
  end

  def gem_rate_count
    (parse_watched_by + parse_stars + parse_forks +
     parse_contributors + parse_used_by) / (parse_issues + 1)
  end
end
