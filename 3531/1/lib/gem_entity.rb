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
    @stats = create_stats
    @score = calc_score
    check_req if @verbose
  end

  private

  def check_req
    STDOUT.print('.')
  end

  def create_stats
    stats = {
      watched_by: watched_by,
      stars: stars,
      forks: forks,
      issues: issues,
      used_by: used_by,
      contributors: contributors
    }
    cleanup(stats)
  end

  def issues
    @doc.css('span.Counter')[0].text
  end

  def used_by
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

  def contributors
    css = 'a span.num.text-emphasized'
    elem = @doc.css(css).text.split(' ') unless @used_by_doc.is_a?(Array)
    elem = @used_by_doc[1].css(css).text.split(' ') if @used_by_doc.is_a?(Array)
    return elem[NO_LICENSE_INDEX] unless elem[LICENSE_INDEX]

    elem[LICENSE_INDEX]
  end

  def cleanup(stats)
    stats.each_value { |val| val.delete!("'' , \n Repositories") }
  end

  def calc_score
    @stats.values.reduce { |sum, val| sum.to_i + val.to_i }
  end
end
