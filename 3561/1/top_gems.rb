class TopGems
  def initialize(options)
    @file = options[:file]
    @name = options[:name]
    @top = options[:top]
  end

  def run
    gems_hash = check_and_sort_gems
    Output.new.print_gems(gems_hash)
  end

  private

  def read_yaml
    file = @file || 'top_gems.yml'
    FileReader.read_yaml(file)['gems']
  end

  def check_and_sort_gems
    gems_hash = create_entity(parse_html(parse_api))
    gems_hash.select! { |gem_hash| gem_hash[:name] == @name } if @name
    gems_hash = Sorter.sort(gems_hash).take(@top) if @top
    gems_hash
  end

  def parse_api
    urls = ApiParser.new(ENV['GITHUB_TOKEN']).urls_of_sites(read_yaml)
    ApiParser.new(ENV['GITHUB_TOKEN']).parse(urls)
  end

  def parse_html(_gems)
    gems_hash.each do |_gem|
      HtmlParser.new(HtmlReader.read_html(gems_hash)).parse
    end
  end

  def create_entity(gems_hash)
    gems = []
    gems_hash.each do |gem_hash|
      gems << GemEntity.new(gem_parmeters: gem_hash, name: gem_hash[:name])
    end
    gems
  end
end
