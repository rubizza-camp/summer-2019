module Extractor
  def run(link)
    extractor(link)
  end

  private

  def extractor(link)
    html = URI.parse(link).open
    document = Nokogiri::HTML(html)
    if link.match?(%r{/network/dependents})
      others(document)
    else
      contributors(document)
    end
  end

  def others(document)
    others = {
      stars: ['a.social-count.js-social-count', 0],
      forks: ['a.social-count', 2],
      watch: ['a.social-count', 0],
      used_by: ['a.btn-link.selected', 0],
      issues: ['span.Counter', 0]
    }
    others.each_pair.with_object({}) do |(column_name, (path, index)), obj|
      obj[column_name] = document.css(path)[index].text.gsub(/\D/, '').to_i
    end
  end

  def contributors(document)
    contributors = document.css('a span.num.text-emphasized').text.split(' ')
    return { contributors: contributors[2].to_i } unless contributors[3]

    { contributors: contributors[3].to_i }
  end
end
