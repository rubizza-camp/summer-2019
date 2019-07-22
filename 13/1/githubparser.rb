# frozen_string_literal: true

# Class for parsing GitHub
class GithubParser
  def prepare_github(url)
    doc = HTTParty.get(url)
    Nokogiri::HTML(doc)
  end

  def clean(node)
    node.text.gsub(/\D/, '').to_i
  end

  def fetch_data(gems_list)
    gems_list.map do |name|
      data = Gems.info(name)
      next if data.empty?
      url = data['source_code_uri'] || data['homepage_uri']
      url = url.gsub( %r[http:\/\/], 'https://')
      doc = prepare_github(url)
      used_by_doc = prepare_github(url + '/network/dependents')

      info = {
        name: name,
        watches: clean(doc.css('a.social-count')[0]),
        used_by: clean(used_by_doc.css('div.table-list-header-toggle').css('.btn-link')[0]),
        stars: clean(doc.css('a.social-count')[1]),
        forks: clean(doc.css('a.social-count')[2]),
        contributors: clean(doc.css('ul.numbers-summary').css('li')[3]),
        issues: clean(doc.css('.Counter')[0])
      }
      info[:rank] = info[:watches] / 10 + info[:used_by] + info[:stars] * 10 + info[:forks] * 10 + info[:contributors] - info[:issues]
      info
    end.compact
  end
end
