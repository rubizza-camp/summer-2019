module Extractor
  def run(link)
    extractor(link)
  end

  private

  # :reek:NilCheck
  # rubocop:disable Security/Open
  def extractor(link)
    html = open(link)
    document = Nokogiri::HTML(html)
    if (link =~ %r{/network/dependents}).nil?
      helper_one(document)
    else
      helper_two(document)
    end
  end
  # rubocop:enable Security/Open

  def helper_one(document)
    {
      issues: document.css('span.Counter')[0].text.gsub(/\D/, ''),
      contributors: contributors(document)
    }
  end

  def helper_two(document)
    {
      stars: document.css('a.social-count.js-social-count').text.gsub(/\D/, ''),
      forks: document.css('a.social-count')[2].text.gsub(/\D/, ''),
      watch: document.css('a.social-count')[0].text.gsub(/\D/, ''),
      used_by: document.css('a.btn-link.selected').text.gsub(/\D/, '')
    }
  end

  def contributors(document)
    contributors = document.css('a span.num.text-emphasized').text.split(' ')
    return contributors[2] unless contributors[3]

    contributors[3]
  end
end
