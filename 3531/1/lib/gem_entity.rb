# rubocop:disable Lint/MissingCopEnableDirective, Naming/AccessorMethodName, Metrics/AbcSize
class GemEntity
  attr_reader :name, :stats, :score
  def initialize(name, doc, used_by_doc, verbose)
    @name = name
    @doc = doc
    @used_by_doc = used_by_doc
    @stats = get_stats
    @score = get_score
    check_req if verbose
  end

  private

  def check_req
    STDERR.print('.')
  end

  def get_stats
    stats = {
      watched_by: @doc.css("a[class='social-count']")[0].text,
      stars: @doc.css("a[class='social-count js-social-count']").text,
      forks: @doc.css("a[class='social-count']")[1].text,
      issues: @doc.css("span[class='Counter']")[0].text,
      used_by: @used_by_doc.css("a[class='btn-link selected']").text,
      contributors: get_contributors
    }

    delete_spaces(stats)
  end

  def get_contributors
    elem = @doc.css("a span[class='num text-emphasized']").text.split(' ')

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

  def get_score
    sum = 0
    @stats.each_value do |val|
      sum += val.delete(',').to_i
    end
    sum
  end
end
