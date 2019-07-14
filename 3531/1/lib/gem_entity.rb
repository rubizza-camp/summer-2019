class GemEntity
  attr_reader :name, :stats, :score

  LICENSE_INDEX = 3
  NO_LICENSE_INDEX = 2

  def initialize(name, doc, used_by_doc, verbose)
    @name = name
    @doc = doc
    @used_by_doc = used_by_doc
    @verbose = verbose
  end

  def set_params
    @stats = set_stats
    @score = set_score
    check_req if @verbose
  end

  private

  def check_req
    STDOUT.print('.')
  end

  def set_stats
    stats = {
      watched_by: watched_by,
      stars: stars,
      forks: forks,
      issues: issues,
      used_by: fetch_used_by,
      contributors: fetch_contributors
    }
    delete_spaces(stats)
  end

  def issues
    @doc.css('span.Counter')[0].text
  end

  def fetch_used_by
    return @used_by_doc.css('a.btn-link.selected').text unless @used_by_doc.is_a?(Array)

    @used_by_doc[0].css('a.btn-link.selected').text
  end

  def forks
    @doc.css('a.social-count')[2].text
  end

  def stars
    @doc.css('a.social-count.js-social-count').text
  end

  def watched_by
    @doc.css('a.social-count')[0].text
  end

  def fetch_contributors
    css = 'a span.num.text-emphasized'
    elem = @doc.css(css).text.split(' ') unless @used_by_doc.is_a?(Array)
    elem = @used_by_doc[1].css(css).text.split(' ') if @used_by_doc.is_a?(Array)
    return elem[NO_LICENSE_INDEX] unless elem[LICENSE_INDEX]

    elem[LICENSE_INDEX]
  end

  def delete_spaces(stats)
    stats.each do |key, val|
      stats[key] = val.delete("'' \n Repositories")
    end

    stats
  end

  def set_score
    sum = 0
    @stats.each_value do |val|
      sum += val.delete(',').to_i
    end
    sum
  end
end
