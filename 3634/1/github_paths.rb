class GitHubPaths

  def fetch(gems)
    proceccor(gems)
  end

  private

  def proceccor(gems)
    github_urls = []
    gems = Psych.load_file(gems)['gems']

    gems.each do |gemm|
      uri = URI("https://rubygems.org/api/v1/gems/#{gemm}.json")
      response = Net::HTTP.get(uri)
      github_urls << "#{JSON.parse(response)["source_code_uri"]}/network/dependents"
      end
    github_urls
  end
end
