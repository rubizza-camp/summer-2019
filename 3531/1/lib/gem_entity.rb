class GemEntity
  attr_reader :name, :stats, :score
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
      used_by: used_by,
      contributors: contributors
    }
    delete_spaces(stats)
  end

  def issues
    @doc.css('span.Counter')[0].text
  end

  def used_by
    @used_by_doc.css('a.btn-link.selected').text
  end

  def forks
    @doc.css('a.social-count')[1].text
  end

  def stars
    @doc.css('a.social-count.js-social-count').text
  end

  def watched_by
    @doc.css('a.social-count.js-social-count').text
  end

  def contributors
    elem = @doc.css('a span.num.text-emphasized').text.split(' ')

    return elem[2] unless elem[3]

    # with license
    elem[3]
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
