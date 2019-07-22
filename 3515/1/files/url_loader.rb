class GemsUrlLoader
  attr_reader :url

  def initialize(gem_name)
    @gem_for_search = gem_name
    @url = source_code_uri
  end

  def source_code_uri
    if check_url(@url = Gems.info(@gem_for_search)['source_code_uri'])
      url
    else
      homepage_uri
    end
  end

  def homepage_uri
    url if check_url(@url = Gems.info(@gem_for_search)['homepage_uri'])
  end

  private

  def check_url(url)
    (url.to_s.include?('//github.com/') && HTTParty.get(url).code == 200)
  end
end
