class RepoBody
  attr_reader :name, :doc, :used_by_doc

  def initialize(gem_name)
    @name = gem_name
    @git_url = set_git_url
    @doc = set_doc
    @used_by_doc = set_used_by_doc
  end

  private

  def set_git_url
    gem_url = "https://rubygems.org/api/v1/gems/#{@name}.json"

    begin
      res = Faraday.get(gem_url)
      res_params = JSON.parse(res.body)
    rescue JSON::ParserError
      system('clear')
      puts '404 gem not found'
      abort
    end
    fetch_url(res_params)
  end

  def fetch_url(res_params)
    git_url = res_params['homepage_uri'] if res_params['homepage_uri']
    git_url = res_params['source_code_uri'] if res_params['source_code_uri']

    git_url.delete_suffix!('/') if git_url.end_with?('/')
    git_url
  rescue NoMethodError
    puts 'git url is not found'
    abort
  end

  def set_doc
    Nokogiri::HTML(Kernel.open(@git_url))
  rescue SocketError
    puts 'tcp connection error'
    abort
  rescue Errno::ENOENT
    puts 'gem without git link'
    abort
  end

  def set_used_by_doc
    Nokogiri::HTML(Kernel.open("#{@git_url}/network/dependents"))
  end
end
