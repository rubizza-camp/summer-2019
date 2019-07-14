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
    helper_one(document) if (link =~ %r{/network/dependents}).nil?
    helper_two(document)
  end
  # rubocop:enable Security/Open

  def helper_one(document)
    {
      stars: document.css('a.social-count.js-social-count').text.gsub(/\D/, ''),
      forks: document.css('a.social-count')[2].text.gsub(/\D/, ''),
      contributors: document.css('a span.num.text-emphasized')[3].text.gsub(/\D/, ''),
      issues: document.css('span.Counter')[0].text.gsub(/\D/, '')
    }
  end

  def helper_two(document)
    { used_by: document.css('a.btn-link.selected').text.gsub(/\D/, ''),
      watch: document.css('a.social-count')[0].text.gsub(/\D/, '') }
  end
end
