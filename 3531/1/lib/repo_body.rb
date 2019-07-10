# rubocop:disable  Lint/MissingCopEnableDirective, Naming/AccessorMethodName, Metrics/LineLength, Metrics/AbcSize

class RepoBody
  attr_reader :name, :stats, :score

  def initialize(gem_name)
    @name = gem_name
    @stats = repo_params
    @score = get_score
  end

  private

  def repo_params
    html_doc = Nokogiri::HTML(open("https://github.com/#{@name}/#{@name}"))

    # you can't get :used_by out of the main file without authentication
    used_by_doc = Nokogiri::HTML(open("https://github.com/#{@name}/#{@name}/network/dependents"))

    get_stats(html_doc, used_by_doc)
  rescue StandardError
    system('clear')
    puts '404 gem not found'
    abort
  end

  def get_stats(doc, used_by_doc)
    stats = {}

    stats[:watched_by] = doc.css("a[class='social-count']")[0].text
    stats[:stars] = doc.css("a[class='social-count js-social-count']").text
    stats[:forks] = doc.css("a[class='social-count']")[1].text
    stats[:issues] = doc.css("span[class='Counter']")[0].text
    stats[:used_by] = used_by_doc.css("a[class='btn-link selected']").text
    stats[:contributors] = get_contributors(doc)

    delete_spaces(stats)
  end

  def get_contributors(doc)
    elem = doc.css("a span[class='num text-emphasized']")

    # without license
    return elem[2].text unless elem[3]

    # with license
    elem[3].text
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
