module Extractor
  def run(link)
    extractor(link)
  end

  private

  def extractor(link)
    html = URI.parse(link).open
    document = Nokogiri::HTML(html)
    if link.match?(%r{/network/dependents})
      helper_one(document)
    else
      helper_two(document)
    end
  end

  def helper_one(document)
    {
      stars: document.css('a.social-count.js-social-count').text.gsub(/\D/, ''),
      forks: document.css('a.social-count')[2].text.gsub(/\D/, ''),
      watch: document.css('a.social-count')[0].text.gsub(/\D/, ''),
      used_by: document.css('a.btn-link.selected').text.gsub(/\D/, '')
    }
  end

  def helper_two(document)
    {
      issues: document.css('span.Counter')[0].text.gsub(/\D/, ''),
      contributors: contributors(document)
    }
  end

  def contributors(document)
    contributors = document.css('a span.num.text-emphasized').text.split(' ')
    return contributors[2] unless contributors[3]

    contributors[3]
  end
end
