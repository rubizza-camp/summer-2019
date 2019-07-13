# rubocop:disable Lint/MissingCopEnableDirective, Naming/AccessorMethodName, Metrics/LineLength, Security/Open

class RepoBody
  attr_reader :name, :doc, :used_by_doc

  def initialize(gem_name)
    @name = gem_name
    @git_url = get_git_url
    @doc = get_doc
    @used_by_doc = get_used_by_doc
  end

  private

  def get_git_url
    gem_url = "https://rubygems.org/api/v1/gems/#{@name}.json"
    res = Faraday.get(gem_url)
    res_params = JSON.parse(res.body)

    git_url = res_params['homepage_uri'] if res_params['homepage_uri']
    git_url = res_params['source_code_uri'] if res_params['source_code_uri']
    git_url.delete_suffix!('/') if git_url.end_with?('/')
    git_url
  end

  def get_doc
    Nokogiri::HTML(open(@git_url))
  rescue StandardError
    system('clear')
    puts '404 gem not found'
    abort
  end

  def get_used_by_doc
    Nokogiri::HTML(open("#{@git_url}/network/dependents"))
  end
end
