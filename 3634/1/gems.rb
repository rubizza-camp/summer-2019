class Gems
  attr_reader :names

  def initialize(gems)
    @names = gems(gems)
    @paths = []
  end

  def links
    paths(@names)
    @paths
  end

  private

  def gems(gems)
    Psych.load_file(gems)['gems']
  end

  def paths(names)
    names.each do |gemm|
      uri = URI("https://rubygems.org/api/v1/gems/#{gemm}.json")
      response = Net::HTTP.get(uri)
      @paths << JSON.parse(response)['source_code_uri']
    end
  end
end
