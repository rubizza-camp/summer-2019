# rubocop:disable Lint/MissingCopEnableDirective, Naming/AccessorMethodName, Metrics/LineLength, Security/Open, Metrics/AbcSize

class RepoBody
  attr_reader :name, :stats, :score

  def initialize(gem_name)
    @name = gem_name
    @stats = repo_params
    @score = get_score
  end

  private

  def repo_params
    git_url = get_git_url

    html_doc = Nokogiri::HTML(open(git_url))

    used_by_doc = Nokogiri::HTML(open("#{git_url}/network/dependents"))

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
    elem = doc.css("a span[class='num text-emphasized']").text.split(' ')
    # without license
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

  def get_git_url
    gem_url = "https://rubygems.org/api/v1/gems/#{@name}.json"
    res = Faraday.get(gem_url)
    res_params = JSON.parse(res.body)

    git_url = res_params['homepage_uri'] if res_params['homepage_uri']
    git_url = res_params['source_code_uri'] if res_params['source_code_uri']
    git_url.delete_suffix!('/') if git_url.end_with?('/')
    git_url
  end
end
